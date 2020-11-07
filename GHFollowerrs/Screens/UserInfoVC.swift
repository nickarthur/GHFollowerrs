//
//  UserInfoVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 11/6/20.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc private func dissmissVC() {
        dismiss(animated: true)
    }

}
