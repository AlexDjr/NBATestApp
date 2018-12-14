//
//  TeamInfoViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 17/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

class TeamInfoViewModel {
    var team: Team?
    var season : Box<String> = Box("2018-19")
    
    init(team: Team) {
        self.team = team
    }
}
