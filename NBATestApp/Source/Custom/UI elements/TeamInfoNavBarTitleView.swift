//
//  PlayersNavBarTitleView.swift
//  NBATestApp
//
//  Created by Alex Delin on 11/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamInfoNavBarTitleView : UIStackView {
    var teamNameLabel : UILabel
    var seasonButton : UIButton
    
    init(teamName: String, season: String) {
        
        let teamNameLabel = UILabel(frame: CGRect.zero)
        let seasonButton = UIButton.init(type: .custom)
        
        self.teamNameLabel = teamNameLabel
        self.seasonButton = seasonButton
        
        super.init(frame: CGRect.zero)
        
        setupView(teamName: teamName, season: season)
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(teamName: String, season: String) {
        axis = .vertical
        addArrangedSubview(teamNameLabel)
        addArrangedSubview(seasonButton)
        
        teamNameLabel.text = teamName
        teamNameLabel.textColor = UIColor.white
        teamNameLabel.textAlignment = .center
        teamNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        
        seasonButton.setTitle(season + " ⩔", for: .normal)
        seasonButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        seasonButton.setTitleColor(UIColor.white, for: .normal)
        seasonButton.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        
    }
    
}
