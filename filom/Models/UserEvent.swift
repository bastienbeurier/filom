//
//  TouchEvent.swift
//  filom
//
//  Created by Bastien Beurier on 6/26/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

struct UserEvent {
    let viewController: String
    let views: [String]
    let location: CGPoint
    let touchViewOrigin: CGPoint
    let touchViewSize: CGSize
    let timestamp: Date
    
    init(view: UIView, point: CGPoint) {
        self.viewController = UIApplication.topViewControllerDescription()
        self.views = view.touchHierarchy()
        
        let originInWindow = view.convert(view.bounds.origin, from: nil)
        self.touchViewOrigin = CGPoint(x: -originInWindow.x, y: -originInWindow.y)
        
        self.touchViewSize = view.bounds.size
        self.location = point
        self.timestamp = Date()
    }
    
}

extension UserEvent : CustomStringConvertible {
    
    var description: String {
        return """
        USER EVENT:
        
        View Controller: \(viewController)
        Views: \(views)
        Touch view origin: \(touchViewOrigin)
        Touch view size: \(touchViewSize)
        Location: \(location)
        \n
        """
    }

}
