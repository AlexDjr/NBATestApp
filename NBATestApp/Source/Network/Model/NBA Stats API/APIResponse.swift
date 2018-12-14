//
//  APIResponse.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct APIResponse : Decodable {
    var resource : String
    var parameters : APIParameters
    var resultSets : [APIResultSets]
}
