//
//  TabSegmentedControl.swift
//  NBATestApp
//
//  Created by Alex Delin on 16/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamInfoSegmentedControl: UISegmentedControl {
    
    var bottomBar = UIView()
    var selectedColor = UIColor()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor) {
        self.init()
        self.selectedColor = color
        setupSegmentedControl()
    }
    
    func setupSegmentedControl(){
        
        insertSegment(withTitle: "Schedule", at: 0, animated: false)
        insertSegment(withTitle: "Roster", at: 1, animated: false)
        selectedSegmentIndex = 0
        
        frame = CGRect(x: 0, y: 60, width: 200, height: 30)
        
        tintColor = .clear
        backgroundColor = .clear
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = selectedColor
        addSubview(bottomBar)
        
        bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(numberOfSegments)).isActive = true
        
        let fontNormal = UIFont.systemFont(ofSize: 16)
        let fontSelected = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let normalTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: fontNormal
        ]
        let selectedTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: fontSelected
        ]
        setTitleTextAttributes(normalTextAttributes, for: UIControl.State())
        setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        setTitleTextAttributes(selectedTextAttributes, for: .selected)
    }
    
}
