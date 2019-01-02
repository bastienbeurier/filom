//
//  UIWindow+Utils.swift
//  filom
//
//  Created by Bastien Beurier on 12/31/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func viewList() -> String {
        var stack: [UIView] = [self]
        var result = ""
        
        var i = 0
        while let view = stack.popLast(), i < 5 {
            i += 1
            result += viewToCsvString(view: view)
            for subview in view.subviews.reversed() {
                stack.append(subview)
            }
        }
        
        return String(result.dropFirst())
    }
    
    func viewToCsvString(view: UIView) -> String {
        return ",1,\(view.frame.origin.x),\(view.frame.origin.y),\(view.frame.size.width),\(view.frame.size.height)"
    }
    
}
