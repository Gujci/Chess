//
//  GameViewController.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

extension Position.Col {
    
    var index: Int {
        switch self {
        case .a: return 0
        case .b: return 1
        case .c: return 2
        case .d: return 3
        case .e: return 4
        case .f: return 5
        case .g: return 6
        case .h: return 7
        }
    }
}

extension Position {
    
    var indices: (row: Int, col: Int) { return (row: row!, col: col!.index) }
}

class GameViewController: UIViewController {
    
    var onGoingGame: Game!
    
    var tiles: [[GameTileView]]!
    
    @IBOutlet weak var board: UIStackView! {
        didSet {
            tiles = board.arrangedSubviews.compactMap { view in
                (view as? UIStackView)?.arrangedSubviews.compactMap { view in view as? GameTileView }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = onGoingGame.titleText(for: User.current)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout()
    }
    
    private func layout() {
        onGoingGame.steps?.forEach { step in
            guard let indices = step.position?.indices else { return }
            tiles[indices.row][indices.col].figure = step.figure
        }
    }
}
