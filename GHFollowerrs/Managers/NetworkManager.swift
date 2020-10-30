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
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
}
