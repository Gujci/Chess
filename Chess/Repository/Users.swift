//
//  Users.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 10..
//  Copyright © 2018. gujci. All rights reserved.
//

import Foundation
import RESTAPI
import SwiftyJSON

public final class Users {
    
    public var current: User?
        
    public func create(user: User, _ done: @escaping (Bool) -> ()) {
        Server.shared.put("/users/\(user._id.uuidString)", data: user) { (err, _: JSON?) in
            done(err == nil)
            self.current = user
        }
    }
    
    public func getUsers(_ done: @escaping ([User]?) -> ()) {
        Server.shared.get("/users") { (err, users: [User]?) in
            guard let users = users else { return }
            done(users)
        }
    }
}
