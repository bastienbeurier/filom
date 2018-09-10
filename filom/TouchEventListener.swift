//
//  TouchEventListener.swift
//  filom
//
//  Created by Bastien Beurier on 6/25/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class TouchEventListener: NSObject {
    
    init(window: UIWindow) {
        super.init()
        
        let recognizers = [
            UITapGestureRecognizer(target: self, action: #selector(self.handleGesture(_:))),
            UIPinchGestureRecognizer(target: self, action: #selector(self.handleGesture(_:))),
            UIRotationGestureRecognizer(target: self, action: #selector(self.handleGesture(_:))),
            UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:))),
            UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:))),
            UILongPressGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))]
        
        for recognizer in recognizers {
            window.addGestureRecognizer(recognizer)
        }
    }
    
    func printGestureInfo(recognizer: UIGestureRecognizer) {
        print("""
            Type: \(type(of: recognizer))
            State: \(recognizer.stateDescription())
            Views: \(recognizer.touchHierarchy())
            View Controller: \(UIApplication.topViewControllerDesc())
            Location: \(recognizer.location())
            \n
            """)
    }
    
    @objc func handleGesture(_ sender: UIGestureRecognizer) {
        guard sender.state == .ended else { return }
        printGestureInfo(recognizer: sender)
    }

}
