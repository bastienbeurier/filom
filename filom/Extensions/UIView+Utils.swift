//
//  UIView+Utils.swift
//  filom
//
//  Created by Bastien Beurier on 9/17/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

extension UIView {

    func touchHierarchy() -> [String] {
        var currentView = self
        var subviews = ["\(type(of: currentView))"]
        while let view = currentView.superview {
            subviews.append("\(type(of: view))")
            currentView = view
        }
        
        return subviews
    }

}
