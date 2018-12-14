//
//  ScdAPIgame.swift
//  NBATestApp
//
//  Created by Alex Delin on 16/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct SCDAPIGame : Decodable {
    var gid : String
    var gcode : String
    var etm : String
    var gdte : String
    var v : SCDAPITeam
    var h : SCDAPITeam
}
