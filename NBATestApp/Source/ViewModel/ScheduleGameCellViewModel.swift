//
//  ScheduleCellViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 18/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class ScheduleGameCellViewModel {
    private var game: ScheduleGame
    private var team: Team
    
    var visitorLogo: UIImage
    var homeLogo: UIImage
    var visitorScore: String
    var homeScore: String
    var gameDate: String
    var gameTime: String
    var visitorRecord: String
    var homeRecord: String
    
    var gameTypeText: String
    var gameTypeIsHidden: Bool
    var gameTypeTextColor: UIColor
    var gameTypeViewBGColor: UIColor
    
    var gameResultText: String
    var gameResultIsHidden: Bool
    var gameResultTextColor: UIColor
    
    init(team: Team, game: ScheduleGame) {
        self.game = game
        self.team = team
        self.visitorLogo = UIImage()
        self.homeLogo = UIImage()
        self.visitorScore = ""
        self.homeScore = ""
        self.gameDate = ""
        self.gameTime = ""
        self.visitorRecord = ""
        self.homeRecord = ""
        self.gameTypeText = ""
        self.gameTypeIsHidden = true
        self.gameTypeTextColor = UIColor.clear
        self.gameTypeViewBGColor = UIColor.clear
        self.gameResultText = ""
        self.gameResultIsHidden = true
        self.gameResultTextColor = UIColor.clear
        setupViewModel()
    }
    
    
    private func setupViewModel() {
        var visitorTeamName = ""
        var homeTeamName = ""
        var isHomeGame = false
        var isGamePlayed = false
        
        if game.homeId == team.id {
            isHomeGame = true
        }
        
        if !game.homeScore.isEmpty {
            isGamePlayed = true
        }
        
        if isHomeGame {
            homeTeamName = team.name
            visitorTeamName = Team.getTeamNameById(game.visitorId) ?? "no-logo"
        } else {
            homeTeamName = Team.getTeamNameById(game.homeId) ?? "no-logo"
            visitorTeamName = team.name
        }
        
        if isGamePlayed {
            gameResultIsHidden = false
            if Int(game.homeScore)! > Int(game.visitorScore)! {
                gameResultText = isHomeGame ? "Win" : "Loss"
                gameResultTextColor = isHomeGame ? UIColor.init(red: 0/255, green: 144/255, blue: 81/255, alpha: 1) : UIColor.init(red: 255/255, green: 15/255, blue: 0/255, alpha: 1)
            } else {
                gameResultText = isHomeGame ? "Loss" : "Win"
                gameResultTextColor = isHomeGame ? UIColor.init(red: 255/255, green: 15/255, blue: 0/255, alpha: 1) : UIColor.init(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
            }
        } else {
            gameResultIsHidden = true
        }
        
        visitorScore = game.visitorScore.count == 0 ? "-" : game.visitorScore
        homeScore = game.homeScore.count == 0 ? "-" : game.homeScore
        visitorLogo = UIImage(named: visitorTeamName)!
        homeLogo = UIImage(named: homeTeamName)!
        visitorRecord = game.visitorRecord
        homeRecord = game.homeRecord
        gameDate = game.date
        
        if let index = game.timeEST.index(of: "T") {
            let indexAfter = game.timeEST.index(after: index)
            let endIndex = game.timeEST.index(index, offsetBy: 5)
            let time = game.timeEST[indexAfter...endIndex]
            gameTime = "  " + time
        }
        
        switch game.type {
        case .preseason:
            gameTypeIsHidden = false
            gameTypeText = "Preseason"
            gameTypeTextColor = .darkText
            gameTypeViewBGColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        case .regular:
            gameTypeIsHidden = true
            gameTypeViewBGColor = .clear
        case .playoffs:
            gameTypeIsHidden = false
            gameTypeText = "Playoffs"
            gameTypeTextColor = .white
            gameTypeViewBGColor = team.primaryColor
        default:
            gameTypeIsHidden = true
            gameTypeViewBGColor = .clear
        }
    }
    
}
