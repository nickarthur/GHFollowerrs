//
//  FollowerCell.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/30/20.
//


import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    
    func setFollower(follower: Follower) {
        userLabel.text = follower.login
        // note I chose to let decoding convert urls into URL type so this diverges from the course
        // to keep it simple i opted to code a method that takes the URL
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userLabel)
        
        let padding: CGFloat = 8
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor) // square
            
        ])
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
        
    
}
