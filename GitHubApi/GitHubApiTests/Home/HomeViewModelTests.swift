//
//  HomeViewModelTests.swift
//  GitHubApiTests
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import XCTest
@testable import GitHubApi

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var service: HomeServiceProtocol!
    var clientMock: NetworkCoreMock!
    var coordinator: HomeCoordinatorProtocol!

    override func setUp() {
        clientMock = NetworkCoreMock()
        service = HomeService(client: clientMock)
        coordinator = HomeCoordinator(navigationController: UINavigationController())
        sut = HomeViewModel(withHome: service, coordinator: coordinator)
    }

    func test_numberResults_whenClientReturnsSucess() {
        let gatewayExpectation = expectation(description: #function)
        let expectedCountModel = 30
        var serviceResult: [User] = []
        service.fetchUsers { (result) in
            switch result {
                case let .success(userResponse):
                    serviceResult = userResponse
                case let .failure(error):
                    XCTFail("Failure of \(error.localizedDescription).")
            }
            gatewayExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(serviceResult.count, expectedCountModel)
        }
    }

    func test_load_whenClientReturnsFailure() {
        let gatewayExpectation = expectation(description: #function)
        self.service = HomeService(client: clientMock)
        clientMock.isFailure = true
        let expectedError = ClientError.invalidHttpResponse
        var gatewayResult: ClientError?
        
        service.fetchUsers { (result) in
            if case let .failure(error) = result {
                gatewayResult = error
            } else {
                XCTFail("Result is different of \(ClientError.self).")
            }
            gatewayExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (_) in
            XCTAssertEqual(gatewayResult?.localizedDescription, expectedError.localizedDescription)
        }
    }
}
