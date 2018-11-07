//
//  AlwaysPoppableDelegate.swift
//  NBATestApp
//
//  Created by Alex Delin on 07/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class AlwaysPoppableDelegate : NSObject, UIGestureRecognizerDelegate {
    
    weak var navigationController: ColorableNavigationController?
    var originalDelegate: UIGestureRecognizerDelegate
    
    init(navigationController: ColorableNavigationController, originalDelegate: UIGestureRecognizerDelegate) {
        self.navigationController = navigationController
        self.originalDelegate = originalDelegate
    }
    
//    we take control of `gestureRecognizer(_:, shouldReceive touch:) in the one specific scenario:
//    when navigation bar is hidden and we want to swipe back to previous controller
//    otherwise forward everything else to the delegate.
    override func responds(to aSelector: Selector) -> Bool {
        if aSelector == #selector(gestureRecognizer(_:shouldReceive:)) {
            return true
        }
        else {
            return self.originalDelegate.responds(to: aSelector)
        }
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return self.originalDelegate
    }
    
    
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let nav = navigationController, nav.isNavigationBarHidden && nav.viewControllers.count > 1 {
            return true
        } else {
            return self.originalDelegate.gestureRecognizer!(gestureRecognizer, shouldReceive: touch)
        }
    }
        
}
