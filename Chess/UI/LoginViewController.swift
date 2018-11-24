//
//  LoginViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit
import GameKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = UIDevice.current.identifierForVendor else { return }
        User.create(user: User(_id: id, name: "test")) { [weak self] isSuccess in
            guard isSuccess else { return }
            DispatchQueue.main.async { self?.performSegue(withIdentifier: "login", sender: self) }
        }
//        let player = GKLocalPlayer.local
//        GKLocalPlayer.local.authenticateHandler = { vc, err in
//            print(vc)
//        }
    }
}
