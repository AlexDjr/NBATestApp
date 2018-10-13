//
//  PlayersNavBarTitleView.swift
//  NBATestApp
//
//  Created by Alex Delin on 11/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersNavBarTitleView : UIStackView {
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
        self.axis = .vertical
        self.addArrangedSubview(self.teamNameLabel)
        self.addArrangedSubview(self.seasonButton)
        
        self.teamNameLabel.text = teamName
        self.teamNameLabel.textAlignment = .center
        self.teamNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        self.seasonButton.setTitle(season + " ⩔", for: .normal)
        self.seasonButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.seasonButton.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1), for: .normal)
        self.seasonButton.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        
    }

}
