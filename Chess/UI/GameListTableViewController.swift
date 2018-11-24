//
//  GameListTableViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

extension Game {
    
    func titleText(for user: User?) -> String? {
        guard let othersName = user?._id == owner?._id ? guest?.name : owner?.name else { return nil }
        return "Game with \(othersName)"
    }
    
    var subTitleText: String { return status?.rawValue ?? "" }
}

class GameListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
    }
    
    private func reload() {
        guard let current = User.current else {
            performSegue(withIdentifier: "logout", sender: self)
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
        
        cell.textLabel?.text = game.titleText(for: User.current)
        cell.detailTextLabel?.text = game.subTitleText

        return cell
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameVC = segue.destination as? GameViewController else { return }
        guard let selectionIndex = tableView.indexPathForSelectedRow?.row else { return }
        guard let selectedGame = Game.allRelated[safe: selectionIndex] else { return }
        gameVC.onGoingGame = selectedGame
    }
    
    // MARK: - Actions
    @IBAction func unwindToGames(_ segue: UIStoryboardSegue) { reload() }
}
