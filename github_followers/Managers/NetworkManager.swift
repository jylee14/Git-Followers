//
//  NetworkManager.swift
//  github_followers
//
//  Created by Jun Lee on 2/8/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    
    private init(){
    }
    
    func getFollowers(of username: String, page: UInt, completed: @escaping (Result<[Followers], GFError>) -> Void){
        let endpoint = "\(baseUrl)/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(.failure(.errorReceived))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
