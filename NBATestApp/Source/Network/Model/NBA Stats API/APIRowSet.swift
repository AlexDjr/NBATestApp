//
//  APIRowSet.swift
//  NBATestApp
//
//  Created by Alex Delin on 03/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

// decodble enum для обработки API
// в rowSet может приходить строка, число или массив
enum APIRowSet {
    case string(String)
    case int(Int)
    case float(Float)
    case array([APIRowSet])
    
    func get() -> Any {
        switch self {
        case .string(let str): return str
        case .int(let num): return num
        case .float(let num): return num
        case .array(let arr): return arr
        }
    }
    
}


extension APIRowSet : Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let float = try? container.decode(Float.self) {
            self = .float(float)
        } else if let array = try? container.decode([APIRowSet].self) {
            self = .array(array)
        } else {
            self = .string("--")
        }
    }
}
