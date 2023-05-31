//
//  ClientSetup.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

protocol ClientSetup {
    var endpoint: String { get }
}

protocol ClientProtocol {
    func requestData<T: Decodable>(with setup: ClientSetup, completion: @escaping (Result<T>) -> Void)
}
