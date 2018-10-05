//
//  Team.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

enum Division : String {
    case atlantic = "Atlantic"
    case central = "Central"
    case southeast = "Southeast"
    case northwest = "Northwest"
    case pacific = "Pacific"
    case southwest = "Southwest"
    
    static func fromHashValue (hashValue: Int) -> Division? {
        switch hashValue {
        case 0: return .atlantic
        case 1: return .central
        case 2: return .southeast
        case 3: return .southwest
        case 4: return .pacific
        case 5: return .southwest
        default: return nil
        }
    }
}

struct Team {
    let id : Int
    let name : String
    let fullName : String
    let division : Division
    
}

let arrTeams = [
    [Team(id: 1610612738, name: "celtics", fullName: "Boston Celtics", division: .atlantic),
     Team(id: 1610612751, name: "nets", fullName: "Brooklyn Nets", division: .atlantic),
     Team(id: 1610612752, name: "knicks", fullName: "New York Knicks", division: .atlantic),
     Team(id: 1610612755, name: "sixers", fullName: "Philadelphia 76ers", division: .atlantic),
     Team(id: 1610612761, name: "raptors", fullName: "Toronto Raptors", division: .atlantic)]
    ,
    [Team(id: 1610612741, name: "bulls", fullName: "Chicago Bulls", division: .central),
     Team(id: 1610612739, name: "cavs", fullName: "Cleveland Cavaliers", division: .central),
     Team(id: 1610612765, name: "pistons", fullName: "Detroit Pistons", division: .central),
     Team(id: 1610612754, name: "pacers", fullName: "Indiana Pacers", division: .central),
     Team(id: 1610612749, name: "bucks", fullName: "Milwaukee Bucks", division: .central)]
    ,
    [Team(id: 1610612737, name: "hawks", fullName: "Atlanta Hawks", division: .southeast),
     Team(id: 1610612766, name: "hornets", fullName: "Charlotte Hornets", division: .southeast),
     Team(id: 1610612748, name: "heat", fullName: "Miami Heat", division: .southeast),
     Team(id: 1610612753, name: "magic", fullName: "Orlando Magic", division: .southeast),
     Team(id: 1610612764, name: "wizards", fullName: "Washington Wizards", division: .southeast)]
    ,
    [Team(id: 1610612743, name: "nuggets", fullName: "Denver Nuggets", division: .northwest),
     Team(id: 1610612750, name: "wolves", fullName: "Minnesota Timberwolves", division: .northwest),
     Team(id: 1610612760, name: "thunder", fullName: "Oklahoma Thunder", division: .northwest),
     Team(id: 1610612757, name: "blazers", fullName: "Portland Trail Blazers", division: .northwest),
     Team(id: 1610612762, name: "jazz", fullName: "Utah Jazz", division: .northwest)]
    ,
    [Team(id: 1610612744, name: "warriors", fullName: "Golden State Warriors", division: .pacific),
     Team(id: 1610612746, name: "clippers", fullName: "Los Angeles Clippers", division: .pacific),
     Team(id: 1610612747, name: "lakers", fullName: "Los Angeles Lakers", division: .pacific),
     Team(id: 1610612756, name: "suns", fullName: "Phoenix Suns", division: .pacific),
     Team(id: 1610612758, name: "kings", fullName: "Sacramento Kings", division: .pacific)]
    ,
    [Team(id: 1610612742, name: "mavs", fullName: "Dallas Mavericks", division: .southwest),
     Team(id: 1610612745, name: "rockets", fullName: "Houston Rockets", division: .southwest),
     Team(id: 1610612763, name: "grizzlies", fullName: "Memphis Grizzlies", division: .southwest),
     Team(id: 1610612740, name: "pelicans", fullName: "New Orleans Pelicans", division: .southwest),
     Team(id: 1610612759, name: "spurs", fullName: "San Antonio Spurs", division: .southwest)]
]

    

