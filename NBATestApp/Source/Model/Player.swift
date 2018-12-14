//
//  File.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

struct Player {
    var teamID: Int
    var season: String
    var leagueID: String
    var fullName : String
    var number : String
    var position : String
    var height : String
    var weight : String
    var birthDate : String
    var age : Int
    var expirience : String
    var school : String
    var playerID : Int
    var photo : UIImage?
    var firstName : String? {
        get {
            let fio = fullName.components(separatedBy: " ")
            if fio.count == 1 {
                return nil
            } else {    
                return fio[0]
            }
        }
    }
    var lastName : String {
        get {
            let fio = fullName.components(separatedBy: " ")
            if fio.count == 1 {
                return fio[0]
            } else if fio.count == 2 {
                return fio[1]
            } else if fio.count == 3 {
                let postfix = fio[2].components(separatedBy: ".")
                return fio[1] + "_" + postfix[0]
            } else {
                return fio[0]
            }
        }
    }
}
