//
//  TouchEvent.swift
//  filom
//
//  Created by Bastien Beurier on 6/26/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

struct TouchEvent {
    let gesture: String
    let state: String
    let viewController: String
    let views: [String]
    let location: CGPoint
    let timestamp: Date
    
    init(recognizer: UIGestureRecognizer) {
        self.gesture = recognizer.gestureDescription()
        self.state = recognizer.stateDescription()
        self.viewController = UIApplication.topViewControllerDescription()
        self.views = recognizer.touchHierarchy()
        self.location = recognizer.location()
        self.timestamp = Date()
    }
}

extension TouchEvent : CustomStringConvertible {
    
    var description: String {
        return """
        Type: \(gesture)
        State: \(state)
        View Controller: \(viewController)
        Views: \(views)
        Location: \(location)
        \n
        """
    }

}
