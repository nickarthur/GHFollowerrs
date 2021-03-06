//
//  FollwersListVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/27/20.
//

import UIKit

class FollowersListVC: UIViewController {

    var userName: String!
    var page: Int = 1
    var perPage: Int = 100
    var hasMoreFollowers = true
    var isSearching = false
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
            
    enum Section {
        case main
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getFollowers(userName: userName, page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseID)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = NSLocalizedString("Search for a username", comment: "search for a user")
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    private func getFollowers(userName: String, page: Int) {
        
        self.showLoadingView()
        
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < self.perPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)

                if self.followers.isEmpty {
                    let message = NSLocalizedString("This user doesn't have any followers. Go follow them.", comment: "no followers found")
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(with: self.followers)

            case .failure(let error):
                let title = NSLocalizedString("Request Error", comment: "Request Error")
                self.presentGFAlertOnMainThread(title: title,
                                                message: error.localizedString,
                                                buttonTitle: GFButton.defaultTitle)
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView,
                                                                           cellProvider: { (collectionView,
                                                                                            indexPath,
                                                                                            follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID,
                                                          for: indexPath) as! FollowerCell
            cell.setFollower(follower: follower)
            return cell
            
        })
    }
    
    
    func updateData(with followers: [Follower]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers,toSection: .main)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}


extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        
        let navController = UINavigationController(rootViewController: destVC)
        navController.navigationBar.prefersLargeTitles = false
        present(navController, animated: true, completion: nil)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(searchText.lowercased())  }
        isSearching = true
        updateData(with: filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(with: self.followers)
    }
}
