//
//  TeamsCellViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 17/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamsCellViewModel {
    private var team: Team
    
    var teamLogo: UIImage {
        return UIImage(named: team.name)!
    }
    
    init(team: Team) {
        self.team = team
    }
}
