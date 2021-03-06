//
//  GFAvatarImageView.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/30/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let cache = NetworkManager.cache
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
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            return // note placeholder image will be displayed in case error occurs
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
    
    
    func downloadImage(from url: URL) {
        
        let urlString = url.absoluteString
        let cacheKey  = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { return }
       
            self.cache.setObject(image, forKey: cacheKey)
    
            DispatchQueue.main.async { self.image = image }
        })
        task.resume()
    }
}
