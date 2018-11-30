//
//  FilomData.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class FilomData: NSObject {
    
    static var events : [UserEvent] = []
    static var states : [ViewState] = []

    static func clear() {
        events = []
        states = []
    }
    
    static func getSteps() -> [UserEvent] {
        guard states.count > 0 else { return [] }
        
        var steps : [UserEvent] = []
        
        for state in states[1...] {
            
            var lastEvent : UserEvent? = nil
            for event in events {
                
                if event.timestamp < state.timestamp {
                    lastEvent = event
                } else {
                    break
                }
            }
            
            if let event = lastEvent {
                steps.append(event)
            }
        }
        
        return steps
    }
    
}
