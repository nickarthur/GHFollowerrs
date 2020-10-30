//
//  FollwersListVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/27/20.
//

import UIKit

class FollwersListVC: UIViewController {

    var userName: String!
    var followers: [Follower]?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NewtworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
                break
            case .failure(let error):
                let title = NSLocalizedString("Request Error", comment: "Request Error")
                self.presentGFAlertOnMainThread(title: title, message: error.localizedString, buttonTitle: GFButton.defaultTitle)
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
