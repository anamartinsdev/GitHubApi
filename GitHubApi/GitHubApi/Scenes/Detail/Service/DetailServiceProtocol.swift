//
//  DetailServiceProtocol.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
protocol DetailServiceProtocol {
    func fetchUserDetail(username: String, completion: @escaping (Result<UserDetail>) -> Void)
}
