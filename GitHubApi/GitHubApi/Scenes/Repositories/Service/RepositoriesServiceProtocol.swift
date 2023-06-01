//
//  RepositoriesServiceProtocol.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation

protocol RepositoriesServiceProtocol {
    func fetchUserRepositories(username: String, completion: @escaping (Result<[Repository]>) -> Void)
}
