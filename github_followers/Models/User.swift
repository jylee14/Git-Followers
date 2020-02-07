//
//  User.swift
//  github_followers
//
//  Created by Jun Lee on 2/6/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

struct User: Codable{
    var login: String           // github user id
    var avatarUrl: String       // github avatar picture link.
    var htmlUrl: String         // github url to this user
    var followersUrl: String    // followers here
    
    var name: String?
    var email: String?
    var location: String?
    var bio: String?
    
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    
    var createdAt: String
}
