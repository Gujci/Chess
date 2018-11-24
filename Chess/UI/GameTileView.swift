//
//  GameTileView.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

extension Figure {
    
    var image: UIImage? {
        guard let kind = kind, let side = side else { return nil }
        switch (kind, side) {
        case (.king, .dark): return #imageLiteral(resourceName: "king_dark")
        case (.queen, .dark): return #imageLiteral(resourceName: "queen_dark")
        case (.bishop, .dark): return #imageLiteral(resourceName: "bishop_dark")
        case (.knight, .dark): return #imageLiteral(resourceName: "knight_dark")
        case (.rook, .dark): return #imageLiteral(resourceName: "rook_dark")
        case (.pawn, .dark): return #imageLiteral(resourceName: "pawn_dark")
        case (.king, .light): return #imageLiteral(resourceName: "king_light")
        case (.queen, .light): return #imageLiteral(resourceName: "queen_light")
        case (.bishop, .light): return #imageLiteral(resourceName: "bishop_light")
        case (.knight, .light): return #imageLiteral(resourceName: "knight_light")
        case (.rook, .light): return #imageLiteral(resourceName: "rook_light")
        case (.pawn, .light): return #imageLiteral(resourceName: "pawn_light")
        }
    }
}

@IBDesignable
class GameTileView: UIView {
    
    enum State {
        case selected
    }
    
    var figure: Figure?
    
    lazy var imageView: UIImageView = {
        return UIImageView(frame: frame)
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        imageView.image = figure?.image
        if imageView.superview == nil { addSubview(imageView) }
    }
}
