//
//  LoginViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

private let userNameKey = "USER_NAME"

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let deviceId = UIDevice.current.identifierForVendor else { return }
        guard let name = UserDefaults.standard.object(forKey: userNameKey) as? String else {
            promtUserName(with: deviceId)
            return
        }
        login(with: name, id: deviceId)
    }
    
    private func promtUserName(with devideId: UUID) {
        let alert = UIAlertController(title: "Hello!", message: "Please inter yout name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "name" }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
            guard let name = alert?.textFields?[0].text else { return }
            UserDefaults.standard.set(name, forKey: userNameKey)
            UserDefaults.standard.synchronize()
            self?.login(with: name, id: devideId)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func login(with name: String, id: UUID) {
        User.create(user: User(_id: id, name: name)) { [weak self] isSuccess in
            guard isSuccess else { return }
            DispatchQueue.main.async { self?.performSegue(withIdentifier: "login", sender: self) }
        }
    }
}
