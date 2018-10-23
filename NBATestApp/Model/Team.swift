//
//  Team.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

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
    let foundationYear : String
    let primaryColor : UIColor
    let secondColor : UIColor
    
    var seasons : [String] {
        get {
            var yearsArray = [String]()
            var year = foundationYear
            while year != "2019" {
                yearsArray.append(year + "-" + String(Int(year)! + 1).suffix(2))
                year = String(Int(year)! + 1)
            }
            return yearsArray 
        }
    }
    
    static func getTeamNameById(_ id: Int) -> String? {
        for division in arrTeams {
            for team in division {
                if team.id == id {
                    return team.name
                }
            }
        }
        return nil
    }
    
}

let arrTeams = [
    [Team(id: 1610612738, name: "celtics", fullName: "Boston Celtics", division: .atlantic, foundationYear: "1949", primaryColor: #colorLiteral(red: 0.01475526113, green: 0.4787167907, blue: 0.1943529844, alpha: 1), secondColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
     Team(id: 1610612751, name: "nets", fullName: "Brooklyn Nets", division: .atlantic, foundationYear: "1976", primaryColor: #colorLiteral(red: 0.1727933884, green: 0.1650911868, blue: 0.1399868727, alpha: 1), secondColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
     Team(id: 1610612752, name: "knicks", fullName: "New York Knicks", division: .atlantic, foundationYear: "1946", primaryColor: #colorLiteral(red: 0.9574713111, green: 0.5105925798, blue: 0.1739672422, alpha: 1), secondColor: #colorLiteral(red: 0.7284089923, green: 0.7560281157, blue: 0.8100447059, alpha: 1)),
     Team(id: 1610612755, name: "sixers", fullName: "Philadelphia 76ers", division: .atlantic, foundationYear: "1949", primaryColor: #colorLiteral(red: 0.01408611704, green: 0.2411997914, blue: 0.6416828632, alpha: 1), secondColor: #colorLiteral(red: 0.8329946399, green: 0.005276874173, blue: 0.205629617, alpha: 1)),
     Team(id: 1610612761, name: "raptors", fullName: "Toronto Raptors", division: .atlantic, foundationYear: "1995", primaryColor: #colorLiteral(red: 0.7495643497, green: 0.1016408876, blue: 0.2400626838, alpha: 1), secondColor: #colorLiteral(red: 0.1730466783, green: 0.1530793905, blue: 0.1403797567, alpha: 1))]
    ,
    [Team(id: 1610612741, name: "bulls", fullName: "Chicago Bulls", division: .central, foundationYear: "1966", primaryColor: #colorLiteral(red: 0.7378526926, green: 0.01597635262, blue: 0.1713573337, alpha: 1), secondColor: #colorLiteral(red: 0.184999764, green: 0.1570312679, blue: 0.1400741339, alpha: 1)),
     Team(id: 1610612739, name: "cavs", fullName: "Cleveland Cavaliers", division: .central, foundationYear: "1970", primaryColor: #colorLiteral(red: 0.4239670038, green: 0.1487415135, blue: 0.2340034544, alpha: 1), secondColor: #colorLiteral(red: 0.7931044698, green: 0.5917161107, blue: 0.1456063688, alpha: 1)),
     Team(id: 1610612765, name: "pistons", fullName: "Detroit Pistons", division: .central, foundationYear: "1948", primaryColor: #colorLiteral(red: 0.8329455256, green: 0.0341376178, blue: 0.2363829613, alpha: 1), secondColor: #colorLiteral(red: 0.01748972572, green: 0.2736108899, blue: 0.6693561673, alpha: 1)),
     Team(id: 1610612754, name: "pacers", fullName: "Indiana Pacers", division: .central, foundationYear: "1976", primaryColor: #colorLiteral(red: 0.9370502963, green: 0.6985528645, blue: 0.1817214367, alpha: 1), secondColor: #colorLiteral(red: 0.01431405265, green: 0.1826359034, blue: 0.3904019594, alpha: 1)),
     Team(id: 1610612749, name: "bucks", fullName: "Milwaukee Bucks", division: .central, foundationYear: "1968", primaryColor: #colorLiteral(red: 0.1019218937, green: 0.2131198645, blue: 0.1430254579, alpha: 1), secondColor: #colorLiteral(red: 0.7464025617, green: 0.7036607862, blue: 0.5863190293, alpha: 1))]
    ,
    [Team(id: 1610612737, name: "hawks", fullName: "Atlanta Hawks", division: .southeast, foundationYear: "1949", primaryColor: #colorLiteral(red: 0.7299010754, green: 0.03674291447, blue: 0.1671955585, alpha: 1), secondColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
     Team(id: 1610612766, name: "hornets", fullName: "Charlotte Hornets", division: .southeast, foundationYear: "1988", primaryColor: #colorLiteral(red: 0.01481212769, green: 0.4619079828, blue: 0.5500709414, alpha: 1), secondColor: #colorLiteral(red: 0.1133282259, green: 0.0876923576, blue: 0.2711466253, alpha: 1)),
     Team(id: 1610612748, name: "heat", fullName: "Miami Heat", division: .southeast, foundationYear: "1988", primaryColor: #colorLiteral(red: 0.5951363444, green: 0.00567096984, blue: 0.1710173488, alpha: 1), secondColor: #colorLiteral(red: 0.02857308462, green: 0.09737440199, blue: 0.1390219033, alpha: 1)),
     Team(id: 1610612753, name: "magic", fullName: "Orlando Magic", division: .southeast, foundationYear: "1989", primaryColor: #colorLiteral(red: 0.01365188695, green: 0.4485436678, blue: 0.7392261624, alpha: 1), secondColor: #colorLiteral(red: 0.771318078, green: 0.8115982413, blue: 0.8325001597, alpha: 1)),
     Team(id: 1610612764, name: "wizards", fullName: "Washington Wizards", division: .southeast, foundationYear: "1961", primaryColor: #colorLiteral(red: 0.8012502789, green: 0.04069424421, blue: 0.1894752979, alpha: 1), secondColor: #colorLiteral(red: 0.01679950766, green: 0.1340314448, blue: 0.2669061422, alpha: 1))]
    ,
    [Team(id: 1610612743, name: "nuggets", fullName: "Denver Nuggets", division: .northwest, foundationYear: "1976", primaryColor: #colorLiteral(red: 0.05045078695, green: 0.135101229, blue: 0.2347364426, alpha: 1), secondColor: #colorLiteral(red: 0.9897555709, green: 0.7774603963, blue: 0.1484747827, alpha: 1)),
     Team(id: 1610612750, name: "wolves", fullName: "Minnesota Timberwolves", division: .northwest, foundationYear: "1989", primaryColor: #colorLiteral(red: 0.0123170251, green: 0.1672717929, blue: 0.3625766933, alpha: 1), secondColor: #colorLiteral(red: 0.4659893513, green: 0.7512825131, blue: 0.2667530775, alpha: 1)),
     Team(id: 1610612760, name: "thunder", fullName: "Oklahoma Thunder", division: .northwest, foundationYear: "1967", primaryColor: #colorLiteral(red: 0.02773618139, green: 0.4544469714, blue: 0.8032537103, alpha: 1), secondColor: #colorLiteral(red: 0.8603603244, green: 0.2044515014, blue: 0.1275346577, alpha: 1)),
     Team(id: 1610612757, name: "blazers", fullName: "Portland Trail Blazers", division: .northwest, foundationYear: "1970", primaryColor: #colorLiteral(red: 0.8087362051, green: 0.204128176, blue: 0.2264220715, alpha: 1), secondColor: #colorLiteral(red: 0.02102627233, green: 0.08981592208, blue: 0.1190670505, alpha: 1)),
     Team(id: 1610612762, name: "jazz", fullName: "Utah Jazz", division: .northwest, foundationYear: "1974", primaryColor: #colorLiteral(red: 0.01679950766, green: 0.1340314448, blue: 0.2669061422, alpha: 1), secondColor: #colorLiteral(red: 0.8338185549, green: 0.5359840989, blue: 0.03337785602, alpha: 1))]
    ,
    [Team(id: 1610612744, name: "warriors", fullName: "Golden State Warriors", division: .pacific, foundationYear: "1946", primaryColor: #colorLiteral(red: 0.01728303544, green: 0.2733939588, blue: 0.6733552217, alpha: 1), secondColor: #colorLiteral(red: 0.9738251567, green: 0.7734617591, blue: 0.1881295443, alpha: 1)),
     Team(id: 1610612746, name: "clippers", fullName: "Los Angeles Clippers", division: .pacific, foundationYear: "1970", primaryColor: #colorLiteral(red: 0.8329302669, green: 0.04594286531, blue: 0.2406748831, alpha: 1), secondColor: #colorLiteral(red: 0.01728303544, green: 0.2733939588, blue: 0.6733552217, alpha: 1)),
     Team(id: 1610612747, name: "lakers", fullName: "Los Angeles Lakers", division: .pacific, foundationYear: "1948", primaryColor: #colorLiteral(red: 0.3350814581, green: 0.1788631678, blue: 0.5172798038, alpha: 1), secondColor: #colorLiteral(red: 0.9791906476, green: 0.6858353615, blue: 0.2057477832, alpha: 1)),
     Team(id: 1610612756, name: "suns", fullName: "Phoenix Suns", division: .pacific, foundationYear: "1968", primaryColor: #colorLiteral(red: 0.8990041614, green: 0.3829587102, blue: 0.1540929377, alpha: 1), secondColor: #colorLiteral(red: 0.9839666486, green: 0.6302967668, blue: 0.1311943531, alpha: 1)),
     Team(id: 1610612758, name: "kings", fullName: "Sacramento Kings", division: .pacific, foundationYear: "1972", primaryColor: #colorLiteral(red: 0.3231201172, green: 0.1794525087, blue: 0.5093445182, alpha: 1), secondColor: #colorLiteral(red: 0.3832480311, green: 0.4150617719, blue: 0.4566838145, alpha: 1))]
    ,
    [Team(id: 1610612742, name: "mavs", fullName: "Dallas Mavericks", division: .southwest, foundationYear: "1980", primaryColor: #colorLiteral(red: 0.01267580222, green: 0.3891739249, blue: 0.6839927435, alpha: 1), secondColor: #colorLiteral(red: 0.7323409319, green: 0.7645815015, blue: 0.7812849879, alpha: 1)),
     Team(id: 1610612745, name: "rockets", fullName: "Houston Rockets", division: .southwest, foundationYear: "1967", primaryColor: #colorLiteral(red: 0.8011749983, green: 0.06398909539, blue: 0.2551396191, alpha: 1), secondColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
     Team(id: 1610612763, name: "grizzlies", fullName: "Memphis Grizzlies", division: .southwest, foundationYear: "1995", primaryColor: #colorLiteral(red: 0.04589816183, green: 0.1344285011, blue: 0.2548150122, alpha: 1), secondColor: #colorLiteral(red: 0.4857718945, green: 0.6049729586, blue: 0.7670611739, alpha: 1)),
     Team(id: 1610612740, name: "pelicans", fullName: "New Orleans Pelicans", division: .southwest, foundationYear: "2002", primaryColor: #colorLiteral(red: 0.05853444129, green: 0.1449483952, blue: 0.2580252742, alpha: 1), secondColor: #colorLiteral(red: 0.7735205889, green: 0.02739831619, blue: 0.1733433604, alpha: 1)),
     Team(id: 1610612759, name: "spurs", fullName: "San Antonio Spurs", division: .southwest, foundationYear: "1976", primaryColor: #colorLiteral(red: 0.01586705633, green: 0.007666901685, blue: 0.01591251418, alpha: 1), secondColor: #colorLiteral(red: 0.7835755944, green: 0.8079138398, blue: 0.8120980859, alpha: 1))]
]

    

