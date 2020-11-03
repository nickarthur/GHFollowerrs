//
//  GFAvatarImageView.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/30/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage //sensible default if user has no avatar url
    }
    
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return // note placeholder image will be displayed in case error occurs
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from url: URL) {
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: { (data, response, error) in
            guard error == nil, let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = UIImage(data: data)
            }
        })
        task.resume()
    }
}
