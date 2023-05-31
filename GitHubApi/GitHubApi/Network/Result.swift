//
//  Result.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ClientError)
}
