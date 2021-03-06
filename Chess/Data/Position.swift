//
// Position.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import RESTAPI

public struct Position: Codable {

    public enum Col: String, Codable { 
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case e = "e"
        case f = "f"
        case g = "g"
        case h = "h"
    }
    
    public var col: Col?
    public var row: Int?
    
    public init(col: Col?, row: Int?) { 
        self.col = col
        self.row = row
    }
}

extension Position: ValidJSONData { }

extension Position: JSONCodable { }

extension Position: Equatable { }
