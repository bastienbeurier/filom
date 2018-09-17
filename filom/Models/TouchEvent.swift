//
//  TouchEvent.swift
//  filom
//
//  Created by Bastien Beurier on 6/26/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

struct TouchEvent {
    let viewController: String
    let views: [String]
    let location: CGPoint
    let timestamp: Date
    
    init(view: UIView, point: CGPoint) {
        self.viewController = UIApplication.topViewControllerDescription()
        self.views = view.touchHierarchy()
        self.location = point
        self.timestamp = Date()
    }
}

extension TouchEvent : CustomStringConvertible {
    
    var description: String {
        return """
        View Controller: \(viewController)
        Views: \(views)
        Location: \(location)
        \n
        """
    }

}
