//
//  UIGestureRecognizer+Utils.swift
//  filom
//
//  Created by Bastien Beurier on 9/10/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    
    func stateDescription() -> String {
        switch self.state {
        case .began:
            return "Began"
        case .cancelled:
            return "Cancelled"
        case .changed:
            return "Changed"
        case .ended:
            return "Ended"
        case .failed:
            return "Failed"
        case .possible:
            return "Possible"
        }
    }
    
    func location() -> CGPoint {
        return self is UITapGestureRecognizer ? self.location(ofTouch: 0, in: self.view) : self.location(in: self.view)
    }
    
    func touchHierarchy() -> String {
        guard let view = self.view, var topView = view.hitTest(self.location(in: view), with: nil) else {
            return ""
        }
        
        var subviewsDesc = "\(type(of: topView))"
        while let view = topView.superview {
            subviewsDesc += ", \(type(of: view))"
            topView = view
        }
        
        return subviewsDesc
    }

}
