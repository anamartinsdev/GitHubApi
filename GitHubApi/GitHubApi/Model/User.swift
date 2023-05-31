//
//  User.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let avatarURL: String?
    let url: String
    let htmlURL: String?
    let gistsURL: String?
    let type: String?
    let isSiteAdmin: Bool?

    private enum CodingKeys: String, CodingKey {
        case login, id
        case nodeId = "node_id"
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case gistsURL = "gists_url"
        case type
        case isSiteAdmin = "site_admin"
    }

    init() {
        login = ""
        id = 0
        nodeId = ""
        avatarURL = ""
        url = ""
        htmlURL = ""
        gistsURL = ""
        type = ""
        isSiteAdmin = false
    }
}
