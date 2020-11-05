//
//  UIViewController+Ext.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import UIKit

#warning(" TODO: REMOVE THIS global var for this file only")
fileprivate var containerView: UIView?

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func showLoadingView() {
        
        containerView = UIView(frame: view.bounds)
        guard let containerView = containerView else { return }
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGreen
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }

}

