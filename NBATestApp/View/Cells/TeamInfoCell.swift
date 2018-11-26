//
//  TeamInfoCell.swift
//  NBATestApp_dev
//
//  Created by Alex Delin on 22/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamInfoCell: UICollectionViewCell {
    static let reuseIdentifier = "teamInfoCell"
    
    var hostedView: UIView? {
        didSet {
            guard let hostedView = hostedView else {
                return
            }
            
            hostedView.frame = contentView.bounds
            contentView.addSubview(hostedView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //Making sure that hostedView hasn't been added as a subview to a different cell
        if hostedView?.superview == contentView {
            hostedView?.removeFromSuperview()
        } else {
            print("hostedView is no longer attached to this cell")
        }
        
        hostedView = nil
    }
}
