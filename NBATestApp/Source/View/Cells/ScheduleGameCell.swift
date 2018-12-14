//
//  ScheduleGameCell.swift
//  NBATestApp
//
//  Created by Alex Delin on 19/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class ScheduleGameCell: UITableViewCell {

    @IBOutlet var visitorLogo: UIImageView!
    @IBOutlet var homeLogo: UIImageView!
    @IBOutlet var visitorScore: UILabel!
    @IBOutlet var homeScore: UILabel!
    @IBOutlet var gameDate: UILabel!
    @IBOutlet var gameTime: UILabel!
    @IBOutlet var visitorRecord: UILabel!
    @IBOutlet var homeRecord: UILabel!
    @IBOutlet var gameType: UILabel!
    @IBOutlet var gameTypeView: UIView!
    @IBOutlet var gameResult: UILabel!
    
    weak var viewModel: ScheduleGameCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            visitorLogo.image = viewModel.visitorLogo
            homeLogo.image = viewModel.homeLogo
            visitorScore.text = viewModel.visitorScore
            homeScore.text = viewModel.homeScore
            gameDate.text = viewModel.gameDate
            gameTime.text = viewModel.gameTime
            visitorRecord.text = viewModel.visitorRecord
            homeRecord.text = viewModel.homeRecord
            gameType.text = viewModel.gameTypeText
            gameType.textColor = viewModel.gameTypeTextColor
            gameType.isHidden = viewModel.gameTypeIsHidden
            gameTypeView.backgroundColor = viewModel.gameTypeViewBGColor
            gameResult.text = viewModel.gameResultText
            gameResult.textColor = viewModel.gameResultTextColor
            gameResult.isHidden = viewModel.gameResultIsHidden
        }
    }
}
