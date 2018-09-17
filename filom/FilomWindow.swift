//
//  FilomWindow.swift
//  filom
//
//  Created by Bastien Beurier on 9/17/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class FilomWindow: UIWindow {
    
    var filomEvent:TouchEvent?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if let view = view  {
            let newFilomEvent = TouchEvent(view: view, point: point)
            
            if filomEvent == nil || newFilomEvent.timestamp.timeIntervalSince(filomEvent!.timestamp) > 0.01 {
               print(newFilomEvent)
            }
            
            filomEvent = newFilomEvent
        }
        
        return view
    }

}
