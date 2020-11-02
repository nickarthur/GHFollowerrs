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
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: NSLocalizedString("Get Followers", comment: ""))
    
    var isUsernameEntered: Bool { return !userNameTextField.text!.isEmpty }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // white/black based on light/dark mode
        configureLogoImageView()
        configureUserNameTextField()
        configureCallToActionButton()
        createDismissKeyboardGesture()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        callToActionButton.isEnabled = isUsernameEntered
    }
    
    
    @objc private func pushFollowersListVC() {
        guard isUsernameEntered else {
            let title = NSLocalizedString("Empty Username", comment: "user name is missing")
            let message = NSLocalizedString("Please enter a username. WE need to know who to look for 😀.", comment: "")
            presentGFAlertOnMainThread(title: title, message: message, buttonTitle: GFButton.defaultTitle)
            return
        }
        
        let followersListVC = FollowersListVC()
        followersListVC.userName = userNameTextField.text
        followersListVC.title = userNameTextField.text
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
        userNameTextField.addDoneAccessoryView()
        userNameTextField.delegate = self
        
        view.addSubview(userNameTextField)
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50) // tappable elements should be at least 44 points
        ])
    }
    
    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        view.addSubview(callToActionButton)
        
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
            
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callToActionButton.isEnabled = isUsernameEntered
    }
}
