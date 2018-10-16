//
//  ScdAPIvisitor.swift
//  NBATestApp
//
//  Created by Alex Delin on 16/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct SCDAPITeam : Decodable {
    var tid : Int
    var re : String
    var ta : String
    var tn : String
    var tc : String
    var s : String
}
