//
//  NetworkCoreMock.swift
//  GitHubApiTests
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import XCTest
@testable import GitHubApi

final class NetworkCoreMock: ClientProtocol {
    
    var isFailure = false
    
    func requestData<T : Decodable>(with setup: ClientSetup, completion: @escaping (Result<T>) -> Void) {
        if isFailure {
            completion(.failure(ClientError.invalidHttpResponse))
            return
        } else {
            completion(generateData())
        }
    }
    
    private func generateData<T: Decodable>() -> Result<T> {
        guard let filePath = Bundle.main.path(forResource: "users", ofType: "json")
        else {
            XCTFail("Could not mock data!")
            return .failure(ClientError.brokenData)
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath),
                                    options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(T.self, from: jsonData)
            return .success(responseModel)
        } catch { }
        return .failure(ClientError.brokenData)
    }
}
