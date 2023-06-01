//
//  DetailService.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

final class DetailService: DetailServiceProtocol {
    private let client: ClientProtocol
    private lazy var queue: OperationQueue = {
        let operation = OperationQueue()
        operation.maxConcurrentOperationCount = 1
        operation.qualityOfService = .userInteractive
        return operation
    }()

    init(client: ClientProtocol) {
        self.client = client
    }

    func fetchUserDetail(username: String,
                         completion: @escaping (Result<UserDetail>) -> Void) {
        queue.addOperation { [weak self] in
            guard let gateway = self else { return }
            gateway.client.requestData(with: DetailDomain.fetchUserDetail(username: username)) { (result: Result<UserDetail>) in
                switch result {
                case let .success(user):
                    completion(.success(user))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
