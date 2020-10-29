//
//  Follower.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: URL

    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
