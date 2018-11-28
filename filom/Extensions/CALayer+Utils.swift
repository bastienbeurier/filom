//
//  CALayer+Utils.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

extension CALayer {
    
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }

}
