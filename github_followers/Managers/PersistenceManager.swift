//
//  PersistenceManager.swift
//  github_followers
//
//  Created by Jun Lee on 2/26/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

enum FavoritesMethod{
    case add, remove
}
    

enum PersistenceManager{
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateFavoritesListWith(_ follower: Followers, method: FavoritesMethod, completed: @escaping (GFError?)->Void){
        retrieveFavorites { result in
            switch result{
            case .success(var followers):
                switch method{
                case .add:
                    guard !followers.contains(follower) else {
                        completed(.alreadyFavorite)
                        return
                    }
                    followers.append(follower)
                case .remove:
                    followers.removeAll { $0.login == follower.login }
                }
                
                return completed(save(favorites: followers))
            case .failure(let error):
                return completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Followers], GFError>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([])) // might have no favorites
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Followers].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            return completed(.failure(GFError.failedRetrieving))
        }
    }
    
    private static func save(favorites: [Followers]) -> GFError?{
        do{
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(favorites)
            defaults.set(encoded, forKey: Keys.favorites)
            return nil
        }catch{
            return GFError.failedAdding
        }
    }
}
