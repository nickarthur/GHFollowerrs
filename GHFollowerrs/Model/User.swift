//
//  User.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: URL
    var htmlUrl: URL
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
    }
}
