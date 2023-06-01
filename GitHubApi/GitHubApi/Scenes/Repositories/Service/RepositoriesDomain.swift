//
//  RepositoriesDomain.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation

enum RepositoriesDomain: ClientSetup {
    case fetchUserRepositories(username: String)

    var endpoint: String {
        switch self {
        case .fetchUserRepositories(let username):
            return fetchUserRepositories("https://api.github.com" + "/users/\(username)/repos")
        }
    }
    
    private func fetchUserRepositories(_ url: String) -> String {
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.queryItems = [URLQueryItem(name: "sort", value: "stars")]

        guard let urlString = urlComponents?.url?.absoluteString else { return url }
        return urlString
    }
}
