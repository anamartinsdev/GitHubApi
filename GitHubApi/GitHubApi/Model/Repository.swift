//
//  Repository.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

struct RepoUserModel: Codable {
    let name: String?
    let fullName: String?
    let htmlURL: String?
    let description: String?
    let language: String?

    private enum CodingKeys: String, CodingKey {
        case name, description, language
        case fullName = "full_name"
        case htmlURL = "html_url"
    }
}
