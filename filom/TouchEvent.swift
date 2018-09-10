//
//  TouchEvent.swift
//  filom
//
//  Created by Bastien Beurier on 6/26/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

struct TouchEvent {
    let type: String
    let startLocation: CGPoint
    let endLocation: CGPoint
    let startTime: Date
    let endTime: Date
    let touchCount: Int
    let currentVC: String
    let views: [Int]
}
