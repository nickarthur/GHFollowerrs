//
//  SearchVC.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/25/20.
//

import UIKit

class SearchVC: UIViewController {

    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField(userSFSymbol: "person.fill")
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // white/black based on light/dark mode
        configureLogoImageView()
        configureUserNameTextField()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        #warning("STRINGLY TYPED! -> gh-logo <- change to constant")
        logoImageView.image = UIImage(named: "gh-logo")! // TODO: "stringly-typed" refactor to constant
                
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50) // tappable elements should be at least 44 points
        ])
    }
}
