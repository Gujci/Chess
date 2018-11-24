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
    
    init?(from index: Int) {
        switch index {
        case 0: self = .a
        case 1: self = .b
        case 2: self = .c
        case 3: self = .d
        case 4: self = .e
        case 5: self = .f
        case 6: self = .g
        case 7: self = .h
        default: return nil
        }
    }
}

extension Position {
    
    init(col: Int, row: Int) { self.init(col: Position.Col(from: col), row: row) }
}

extension Position {
    
    var indices: (row: Int, col: Int) { return (row: row!, col: col!.index) }
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var board: UIStackView! {
        didSet {
            tiles = board.arrangedSubviews.compactMap { view in
                (view as? UIStackView)?.arrangedSubviews.compactMap { view in view as? GameTileView }
            }
        }
    }
    var tiles: [[GameTileView]]! {
        didSet{
            setTilePositions()
        }
    }
    var onGoingGame: Game! {
        didSet{
            layout()
            stopTimer()
        }
    }
    
    private var selectedFigure: Figure?
    private var updateTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = onGoingGame.titleText(for: User.current)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout()
    }
    
    private func setTilePositions() {
        tiles.enumerated().forEach { (rowNum, row) in
            row.enumerated().forEach({ (colNum, tile) in
                tile.position = Position(col: colNum, row: rowNum)
            })
        }
    }
    
    private func layout() {
        guard onGoingGame != nil, tiles != nil else { return }
        tiles.reduce([], +).forEach { $0.figure = nil }
        onGoingGame.latestSteps.forEach { step in
            guard let indices = step.position?.indices else { return }
            tiles[indices.row][indices.col].figure = step.figure
        }
    }
    
    private func startTimer() {
        updateTimer = Timer(timeInterval: 1000, repeats: true) { [weak self] _ in self?.reloadGame() }
    }
    
    private func stopTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func reloadGame() {
        onGoingGame.update { [weak self] updated in self?.onGoingGame = updated }
    }
    
    @IBAction func tilePressed(_ sender: GameTileView) {
        guard let figure = selectedFigure else {
            selectedFigure = sender.figure
            return
        }
        guard figure != sender.figure else {
            selectedFigure = nil
            return
        }
        let next = Step(position: sender.position, figure: figure)
        onGoingGame.add(step: next) { [weak self] isSuccess in
            guard isSuccess else { return }
            self?.onGoingGame.steps?.append(next)
            self?.startTimer()
        }
    }
}
