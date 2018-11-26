//
//  PlayerCell.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet var playerPhoto: UIImageView!
    @IBOutlet var playerName: UILabel!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var playerPosition: UILabel!
    @IBOutlet var playerAge: UILabel!
    @IBOutlet var playerHeight: UILabel!
    @IBOutlet var playerWeight: UILabel!
    @IBOutlet var playerExpirience: UILabel!

    weak var viewModel: PlayersCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            playerPhoto.image = viewModel.playerPhoto
            playerName.text = viewModel.playerName
            playerNumber.text = viewModel.playerNumber
            playerPosition.text = viewModel.playerPosition
            playerAge.text = String(viewModel.playerAge)
            playerHeight.text = viewModel.playerHeight
            playerWeight.text = viewModel.playerWeight
            playerExpirience.text = viewModel.playerExpirience
        }
    }
}
