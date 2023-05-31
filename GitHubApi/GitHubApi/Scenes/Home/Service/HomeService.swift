//
//  HomeService.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

final class HomeService: HomeServiceProtocol {
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

    func fetchUsers(completion: @escaping (Result<[User]>) -> Void) {
        queue.addOperation { [weak self] in
            guard let gateway = self else { return }
            gateway.client.requestData(with: HomeDomain.fetchUsers) { (result: Result<[User]>) in
                switch result {
                case let .success(users):
                    completion(.success(users))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
