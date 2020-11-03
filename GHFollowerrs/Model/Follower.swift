//
//  Follower.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import Foundation

struct Follower: Codable, Hashable { // adopt Hashable to work with diffable datasource
    var login: String
    var avatarUrl: URL

    // not required for this simple example -- as login being a String is hashable
    // NOTE: this could be a UUID if coming from a database for example
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
