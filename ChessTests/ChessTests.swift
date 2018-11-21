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
    lazy var gameRepo: Games = Games()
    
    var otherUser: User?
    var ongoingGame: Game?
    
    func testCreateUser() {
        wrap("login") { success in
            userRepo.create(user: User(_id: UUID(), name: "Test")) { loginSuccess in
                XCTAssertTrue(loginSuccess)
                success()
            }
        }
    }

    func testLoadUsers() {
        wrap("users") { success in
            userRepo.getUsers { users in
                XCTAssertNotEqual(users?.count, 0)
                self.otherUser = users?.first
                success()
            }
        }
    }
    
    func testCreateGame() {
        wrap("createGame") { success in
            guard let other = otherUser else { return }
            guard let newGame = userRepo.current?.invite(other, as: .light) else { return }
            gameRepo.create(game: newGame) { created in
                guard created else { return }
                success()
            }
        }
    }
    
    func testLoadGames() {
        wrap("games") { success in
            gameRepo.getGames { games in
                XCTAssertNotEqual(games?.count, 0)
                self.ongoingGame = games?.last
                success()
            }
        }
    }
    
    // TODO: - step one
    
    private func wrap(_ name: String, _ test: (@escaping () -> ()) -> ()) {
        let expectation = self.expectation(description: "name")
        
        test() { expectation.fulfill() }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error { print("Error: \(error.localizedDescription)") }
        }
    }
}
