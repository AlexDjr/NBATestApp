//
//  DivisionCell.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class DivisionCell: UICollectionReusableView {
    @IBOutlet var divisionNameLabel: UILabel!
    
    weak var viewModel: TeamsSectionHeaderViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            divisionNameLabel.text = viewModel.name
        }
    }
}
