//
//  HomeServiceProtocol.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
protocol HomeServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User]>) -> Void)
}
