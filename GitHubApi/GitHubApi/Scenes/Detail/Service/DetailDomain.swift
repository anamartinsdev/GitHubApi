//
//  DetailDomain.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

enum DetailDomain: ClientSetup {
    case fetchUserDetail(username: String)

    var endpoint: String {
        switch self {
        case .fetchUserDetail(let username):
            return fetchUsers("https://api.github.com" + "/users/\(username)")
        }
    }
    
    private func fetchUsers(_ url: String) -> String {
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.queryItems = [URLQueryItem(name: "sort", value: "stars")]
        
        
        guard let urlString = urlComponents?.url?.absoluteString else { return url }
        return urlString
    }
}
