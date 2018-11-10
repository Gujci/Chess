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
    
    private lazy var server = API(withBaseUrl: "https://chessbackend20181106023517.azurewebsites.net/api")
    
    public func createUser(with data: User, _ done: @escaping (Bool) -> ()) {
        server.put("/users/\(data._id.uuidString)", data: data) { (err, users: JSON?) in
            done(err == nil)
        }
    }
    
    public func getUsers(_ done: @escaping ([User]?) -> ()) {
        server.get("/users") { (err, users: [User]?) in
            guard let users = users else { return }
            done(users)
        }
    }
}
