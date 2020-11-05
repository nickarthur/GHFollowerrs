//
//  GFEmptyStateView.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 11/4/20.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 28)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-state-logo")
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    
    init(message: String) { #warning("convert to convience init")
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // 30% wider
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // and square
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
