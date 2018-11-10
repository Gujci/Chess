//
// Figure.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import RESTAPI

public struct Figure: Codable {

    public enum Kind: String, Codable { 
        case king = "king"
        case queen = "queen"
        case rook = "rook"
        case bishop = "bishop"
        case knight = "knight"
        case pawn = "pawn"
    }
    
    public var kind: Kind?
    public var side: Side?
    public init(kind: Kind?, side: Side?) { 
        self.kind = kind
        self.side = side
    }
}

extension Figure: ValidJSONData { }

extension Figure: JSONCodable { }
