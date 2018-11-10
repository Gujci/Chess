//
//  ChessTests.swift
//  ChessTests
//
//  Created by Gujgiczer Máté on 2018. 11. 10..
//  Copyright © 2018. gujci. All rights reserved.
//

import XCTest
@testable import Chess

class ChessTests: XCTestCase {
    
    lazy var userRepo: Users = Users()
    
    func testCreateUser() {
        let expectation = self.expectation(description: "login")
        
        userRepo.createUser(with: User(_id: UUID(), name: "Test")) { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error { print("Error: \(error.localizedDescription)") }
        }
    }

    func testLoadUsers() {
        let expectation = self.expectation(description: "users")
        
        userRepo.getUsers { users in
            XCTAssertNotEqual(users?.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error { print("Error: \(error.localizedDescription)") }
        }
    }
}
