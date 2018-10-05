//
//  APIResultSets.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct APIResultSets : Decodable {
    var name : String
    var headers : [String]
    var rowSet : [APIRowSet]
}
