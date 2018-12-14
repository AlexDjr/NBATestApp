//
//  MenuBar.swift
//  NBATestApp
//
//  Created by Alex Delin on 20/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamMenuBarView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white//UIColor(red: 50/255, green: 95/255, blue: 215/255, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
