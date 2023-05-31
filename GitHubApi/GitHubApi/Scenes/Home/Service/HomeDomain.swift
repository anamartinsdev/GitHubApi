//
//  HomeDomain.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

enum HomeDomain: ClientSetup {
    case fetchUsers

    var endpoint: String {
        switch self {
        case .fetchUsers:
            return fetchUsers("https://api.github.com" + "/users")
        }
    }
    
    private func fetchUsers(_ url: String) -> String {
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.queryItems = [URLQueryItem(name: "sort", value: "stars")]
        
        
        guard let urlString = urlComponents?.url?.absoluteString else { return url }
        return urlString
    }
}
