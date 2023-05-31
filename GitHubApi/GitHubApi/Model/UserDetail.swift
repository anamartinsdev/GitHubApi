//
//  UserDetail.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

struct UserDetail: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    let url: String?
    let htmlURL: String?
    let gistsURL: String?
    let type: String?
    let isSiteAdmin: Bool?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let bio: String?
    let twitterUsername: String?
    let followers: Int?
    let following: Int?

    private enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case gistsURL = "gists_url"
        case type
        case isSiteAdmin = "site_admin"
        case name, company
        case blog, location, email, bio
        case twitterUsername = "twitter_username"
        case followers, following
    }
}
