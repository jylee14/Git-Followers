//
//  ErrorMessages.swift
//  github_followers
//
//  Created by Jun Lee on 2/8/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername    = "Username is invalid"
    case errorReceived      = "Unable to complete task"
    case invalidResponse    = "Invalid response from the server"
    case invalidData        = "Invalid data received from the server"
    case failedRetrieving   = "Failed to retrieve favorites"
    case failedAdding       = "Failed to add to favorites"
    case alreadyFavorite    = "Cannot favorite the same person twice!"
}
