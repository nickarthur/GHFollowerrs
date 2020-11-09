//
//  User.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: URL
    let htmlUrl: URL
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: String
    
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
