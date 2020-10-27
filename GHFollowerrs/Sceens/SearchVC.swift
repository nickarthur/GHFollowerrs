//
//  SearchVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/25/20.
//

import UIKit

class SearchVC: UIViewController {

    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField(frame: .zero)
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // white/black based on light/dark mode
        configureLogoImageView()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        #warning("STRINGLY TYPED! -> gh-logo <- change to constant")
        logoImageView.image = UIImage(named: "gh-logo")! // TODO: "stringly-typed" refactor to constant
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
