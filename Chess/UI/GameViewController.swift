//
//  GameViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var onGoingGame: Game!
    
    @IBOutlet var tiles: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = onGoingGame.titleText(for: User.current)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout()
    }
    
    private func layout() {
        // TODO: - evaluate steps
    }
}
