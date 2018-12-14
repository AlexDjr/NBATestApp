//
//  ScheduleGame.swift
//  NBATestApp
//
//  Created by Alex Delin on 16/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct ScheduleGame {
    var id : String
    var code : String
    var timeEST : String
    var date : String
    var type : GameType
    var homeId : Int
    var homeRecord : String
    var homeScore : String
    var visitorId : Int
    var visitorRecord : String
    var visitorScore : String
    
    enum GameType : String {
        case preseason = "001"
        case regular = "002"
        case allstar = "003"
        case playoffs = "004"
    }
    
}
