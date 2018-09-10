//
//  UIApplication+Utils.swift
//  filom
//
//  Created by Bastien Beurier on 9/10/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func topViewControllerDesc() -> String {
        if let topVC = topViewController() {
            return "\(type(of: topVC))"
        } else {
            return ""
        }
    }
    
}
