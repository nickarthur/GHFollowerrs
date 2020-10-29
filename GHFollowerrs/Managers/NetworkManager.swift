//
//  NetworkManager.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/29/20.
//

import Foundation

class NewtworkManager {

    static let shared = NewtworkManager()
    let baseURL = "https://api.github.com"
    let perPage = 100
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            let errorMessage = NSLocalizedString("This username created an invalid request. Please try again.",
                                                 comment: "network request failed for username")
            completion(nil, errorMessage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                let errorMessage = NSLocalizedString("Unable to complete your request. Please check your internet connection.", comment: "internet request failed")
                completion(nil, errorMessage)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let errorMessage: String = NSLocalizedString("Invalid response from the server. Please try again.",
                                                             comment: "bad response")
                completion(nil, errorMessage)
                return
            }
            
            guard let data = data else {
                let errorMessage = NSLocalizedString("The data received from the server was invalid.  Please try again.",
                                                     comment: "Invalid data received")
                completion(nil, errorMessage)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                let errorMessage = NSLocalizedString("The data received from the server was invalid.  Please try again.",
                                                     comment: "Invalid data received")
                completion(nil, errorMessage)
            }
        }
        
        task.resume()
        
    }
    
}
