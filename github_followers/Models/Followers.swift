//
//  Followers.swift
//  github_followers
//
//  Created by Jun Lee on 2/6/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

// codable is like C#'s JSON Serializer.
// allows external data (JSON) to be converted to Swift struct
// but for this to work, the fields MUST be named the same
// exception being snake_case -> camelCase for field names
struct Followers: Codable{
    var login: String
    var avatarUrl: String 
}
