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
    static var states : [ViewHierarchy] = []

    static func clear() {
        events = []
        states = []
    }
}
