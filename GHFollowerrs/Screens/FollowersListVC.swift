//
//  FollwersListVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/27/20.
//

import UIKit

class FollowersListVC: UIViewController {

    var userName: String!
    var followers: [Follower]?
    var collectionView: UICollectionView!
            
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        getFollowers()
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
                                          collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.delegate         = self
        collectionView.dataSource       = self
        collectionView.backgroundColor  = .systemPink
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
    
    
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout          = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40) // add space for label
        return flowLayout
    }
    
    
    private func getFollowers() {
        NewtworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
                self.followers = followers
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
                break
            case .failure(let error):
                let title = NSLocalizedString("Request Error", comment: "Request Error")
                self.presentGFAlertOnMainThread(title: title,
                                                message: error.localizedString,
                                                buttonTitle: GFButton.defaultTitle)
                break
            }
        }
    }
}

extension FollowersListVC:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        cell.userLabel.text = followers?[indexPath.row].login
        cell.avatarImageView.image = UIImage()
        cell.avatarImageView.backgroundColor = .systemBlue
        return cell
    }
    
    
}
