//
//  UserListTableViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.getAll { [weak self] _ in DispatchQueue.main.async { self?.tableView.reloadData() } }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return User.others.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = User.others[safe: indexPath.row]?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let invitee = User.others[safe: indexPath.row] else { return }
        guard let invite = User.current?.invite(invitee) else { return } // TODO: side
        Game.create(game: invite) { [weak self] isSuccess in
            guard isSuccess else { return }
            DispatchQueue.main.async { self?.performSegue(withIdentifier: "backToGames", sender: self) }
        }
    }
}
