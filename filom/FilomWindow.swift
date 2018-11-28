//
//  FilomWindow.swift
//  filom
//
//  Created by Bastien Beurier on 9/17/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class FilomWindow: UIWindow {
    
    var isActive = false
    var filomEvent : UserEvent?
    var currentHierarchy : ViewHierarchy? {
        
        didSet {
            self.notifyNewStep()
        }
        
    }
    var timer : Timer?
    
    func startMonitoring() {
        startTimer()
        isActive = true
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        isActive = false
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
            let hierarchy = ViewHierarchy(window: self)
            
            if self.currentHierarchy == nil || !self.currentHierarchy!.isEqual(hierarchy) {
                self.currentHierarchy = hierarchy
            }
        }        
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard isActive else { return view }
        
        if let view = view  {
            let newFilomEvent = UserEvent(view: view, point: point)
            
            if filomEvent == nil || newFilomEvent.timestamp.timeIntervalSince(filomEvent!.timestamp) > 0.01 {
                print(newFilomEvent)
                FilomData.events.append(newFilomEvent)
            }
            
            filomEvent = newFilomEvent
        }
        
        return view
    }
    
    func notifyNewStep() {
        guard let currentHierarchy = self.currentHierarchy else { return }
        print(currentHierarchy)
        FilomData.states.append(currentHierarchy)
    }

}
