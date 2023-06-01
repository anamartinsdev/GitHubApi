//
//  HomeServiceTests.swift
//  GitHubApiTests
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import XCTest
@testable import GitHubApi

final class HomeServiceTests: XCTestCase {
    var sut: HomeService!
    var clientMock = NetworkCoreMock()
    
    override func setUp() {
        sut = HomeService(client: clientMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_getSwiftUsers_whenClientReturnsSucess() {
        let gatewayExpectation = expectation(description: #function)
        let expectedUserName = "mojombo"
        var serviceResult: [User] = []

        sut.fetchUsers { (result) in
            switch result {
                case let .success(userResponse):
                    serviceResult = userResponse
                case .failure:
                    XCTFail("Result is different of \(User.self).")
            }
            gatewayExpectation.fulfill()
        }

        waitForExpectations(timeout: 0.3) { (_) in
            XCTAssertEqual(serviceResult.first?.login, expectedUserName)
        }
    }
    
    func test_getUsers_whenClientReturnsFailure() {
        let gatewayExpectation = expectation(description: #function)
        clientMock.isFailure = true
        let expectedError = ClientError.invalidHttpResponse
        var gatewayResult: ClientError?

        sut.fetchUsers { (result) in
            if case let .failure(error) = result {
                gatewayResult = error
            } else {
                XCTFail("Result is different of \(ClientError.self).")
            }
            gatewayExpectation.fulfill()
        }

        waitForExpectations(timeout: 0.3) { (_) in
            XCTAssertEqual(gatewayResult?.localizedDescription, expectedError.localizedDescription)
        }
    }
    
}
