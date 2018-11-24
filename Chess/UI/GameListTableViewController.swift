//
//  GameListTableViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

extension Game {
    
    var titleText: String { return "Game with ..." }
    
    var subTitleText: String { return status?.rawValue ?? "" }
}

class GameListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
    }
    
    private func reload() {
        guard let current = User.current else {
            performSegue(withIdentifier: "current", sender: self)
            return
        }
        Game.getRelated(to: current) { [weak self] _ in DispatchQueue.main.async { self?.tableView.reloadData() }}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return Game.allRelated.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        guard let game = Game.allRelated[safe: indexPath.row] else { return cell }
        
        cell.textLabel?.text = game.titleText
        cell.detailTextLabel?.text = game.subTitleText

        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - pass game
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToGames(_ segue: UIStoryboardSegue) { reload() }
}
