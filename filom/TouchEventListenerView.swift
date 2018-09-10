//
//  TouchEventListenerView.swift
//  filom
//
//  Created by Bastien Beurier on 6/25/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class TouchEventListenerView: UIView {
    
    // MARK: UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.brown
        self.isHidden = false
    }
    
    convenience required init(coder: NSCoder) {
        self.init(frame: CGRect.zero)
    }

    // MARK: UIResponder

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        printTouches(touches: touches, type: "Began")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        printTouches(touches: touches, type: "Ended")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // MARK: Utils
    
    func printTouches(touches: Set<UITouch>, type: String) {
        for touch in touches {
            print(type + (NSStringFromCGPoint(touch.location(in: touch.view)) as String))
        }
    }
}
