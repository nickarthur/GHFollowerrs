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
    var followers: [Follower] = []
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
    
    
    private func getFollowers(userName: String, page: Int) {
        
        self.showLoadingView()
        
        NewtworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < self.perPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()

            case .failure(let error):
                let title = NSLocalizedString("Request Error", comment: "Request Error")
                self.presentGFAlertOnMainThread(title: title,
                                                message: error.localizedString,
                                                buttonTitle: GFButton.defaultTitle)
                break
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
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
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
        
        print(" Content OffsetY = \(offsetY)")
        print("   ContentHeight = \(contentHeight)")
        print("     scrollView Frame height = \(height)\n")
    }
}
