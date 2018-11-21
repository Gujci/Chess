//
//  Games.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 10..
//  Copyright © 2018. gujci. All rights reserved.
//

import Foundation
import RESTAPI
import SwiftyJSON

public final class Games {
    
    public func getGames(_ done: @escaping ([Game]?) -> ()) {
        Server.shared.get("/games") { (err, games: [Game]?) in
            guard let games = games else { return }
            done(games)
        }
    }
    
    public func create(game: Game, _ done: @escaping (Bool) -> ()) {
        Server.shared.post("/games", data: game) { (err, _: JSON?) in
            done(err == nil)
        }
    }
}

public extension User {
    
    func invite(_ other: User, as side: Side = .light) -> Game {
        return Game(_id: UUID(), owner: self, ownerSide: side, guest: other, steps: nil, status: .pending)
    }
}
