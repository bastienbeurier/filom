//
//  Filom.swift
//  filom
//
//  Created by Bastien Beurier on 6/25/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class Filom: NSObject {
    var touchEventListener: TouchEventListener?
    
    func start(window: UIWindow?) {
        guard let window = window else {
            fatalError("Filom: key window does not exist.")
        }
        
        self.touchEventListener = TouchEventListener(window: window)
    }
    
}
