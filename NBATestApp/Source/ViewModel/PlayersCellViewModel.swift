//
//  PlayersCellModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 25/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersCellViewModel {
    private var player : Player
    
    var playerName: String
    var playerNumber: String
    var playerPosition: String
    var playerAge: Int
    var playerHeight: String
    var playerWeight: String
    var playerExpirience: String
    var playerPhoto: UIImage
    
    init(player: Player) {
        self.player = player
        playerName = player.fullName
        playerNumber = player.number
        playerPosition = player.position
        playerAge = player.age
        playerHeight = player.height
        playerWeight = player.weight
        playerExpirience = player.expirience
        playerPhoto = player.photo!
    }
}
