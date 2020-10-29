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
            let errorMessage = ErrorMessage.invalidUsername.localizedString
            completion(nil, errorMessage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                let errorMessage = ErrorMessage.unableToComplete.localizedString
                completion(nil, errorMessage)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let errorMessage = ErrorMessage.invalidResponse.localizedString
                completion(nil, errorMessage)
                return
            }
            
            guard let data = data else {
                let errorMessage = ErrorMessage.invalidData.localizedString
                completion(nil, errorMessage)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                let errorMessage = ErrorMessage.invalidData.localizedString
                completion(nil, errorMessage)
            }
        }
        
        task.resume()
        
    }
    
}
