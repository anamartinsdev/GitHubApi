//
//  RepositoriesService.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation

final class RepositoriesService: RepositoriesServiceProtocol {
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

    func fetchUserRepositories(username: String,
                         completion: @escaping (Result<[Repository]>) -> Void) {
        queue.addOperation { [weak self] in
            guard let gateway = self else { return }
            gateway.client.requestData(with: RepositoriesDomain.fetchUserRepositories(username: username)) { (result: Result<[Repository]>) in
                switch result {
                case let .success(repositories):
                    completion(.success(repositories))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
