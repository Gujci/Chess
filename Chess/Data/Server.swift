//
//  Server.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 10..
//  Copyright © 2018. gujci. All rights reserved.
//

import RESTAPI

public final class Server {
    
    public static let shared = API(withBaseUrl: "https://chessbackend20181106023517.azurewebsites.net/api")
}
