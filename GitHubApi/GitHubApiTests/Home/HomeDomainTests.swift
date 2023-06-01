//
//  HomeDomainTests.swift
//  GitHubApiTests
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import XCTest
@testable import GitHubApi

final class HomeDomainTests: XCTestCase {
    var sut: HomeDomain!
    
    override func setUp() { }
    
    func testGetSwiftRepositoriesEndpoint() {
        let expectedEndpoint = "https://api.github.com/users?sort=stars"
        
        sut = .fetchUsers
        
        XCTAssertEqual(sut.endpoint, expectedEndpoint)
    }
}
