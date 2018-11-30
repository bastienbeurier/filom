//
//  ViewHierarchy.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

struct ViewState {
    
    let topVC: String
    let viewControllers: String
    let timestamp: Date
    
    init(window: UIWindow) {
        self.topVC = UIApplication.topViewControllerDescription()
        self.timestamp = Date()
        
        var viewControllers = ""
        if let rootVC = window.rootViewController {
            var stack = [(rootVC, 0)]
            
            while stack.count > 0 {
                let currentVC = stack[0].0
                let currentVCLevel = stack[0].1
                viewControllers += "\n\(currentVCLevel)\(type(of: currentVC))"
                stack.removeFirst()
                let children = currentVC.presentedViewController != nil ? [currentVC.presentedViewController!] : currentVC.childViewControllers
                stack = children.map { ($0, currentVCLevel + 1) } + stack
            }
        } else {
            viewControllers = "No view controller in hierarchy."
        }
        
        self.viewControllers = viewControllers
    }
    
    func isEqual(_ hierarchy: ViewState) -> Bool {
        return self.topVC == hierarchy.topVC && self.viewControllers == hierarchy.viewControllers
    }
    
}

extension ViewState : CustomStringConvertible {
    
    var description: String {
        return """
        VIEW HIERARCHY:
        
        Top View Controller: \(topVC)
        View Controllers: \(viewControllers)
        \n
        """
    }
    
}
