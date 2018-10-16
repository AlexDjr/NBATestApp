//
//  APIParameters.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct APIParameters : Decodable{
    var TeamID : Int?
    var LeagueID : String?
    var Season : String?
}
