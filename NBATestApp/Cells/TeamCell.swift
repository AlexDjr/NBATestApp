//
//  TeamCell.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamCell: UICollectionViewCell {    
    @IBOutlet var teamLogo: UIImageView!
    
    weak var viewModel: TeamsCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            teamLogo.image = viewModel.teamLogo
        }
    }
}
