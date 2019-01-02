//
//  FilomWindow.swift
//  filom
//
//  Created by Bastien Beurier on 9/17/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class FilomWindow: UIWindow {

    let logger = FilomLogger()
    let recordButton: FilomButton = {
        let button = FilomButton()
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func startMonitoring() {
        toggleRecordButton(show: true)
    }
    
    func stopMonitoring() {
        toggleRecordButton(show: false)
    }
    
    func logViewList() {
        let topVCDesc = UIApplication.topViewControllerDescription()
        logger.logToLine(writeString: topVCDesc + "," + viewList())
        
        let alert = UIAlertController(title: "", message: "Recorded \(topVCDesc)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }

    func toggleRecordButton(show: Bool) {
        if show {
            addSubview(recordButton)
        } else {
            recordButton.removeFromSuperview()
        }
    }
    
}

extension FilomWindow {
    
    @objc func recordButtonTapped(sender : UIButton){
        logViewList()
    }
    
}

extension UIWindow {
    
    func viewList() -> String {
        var stack: [UIView] = [self]
        var result = ""
        
        var i = 0
        while let view = stack.popLast(), i < 5 {
            i += 1
            result += viewToCsvString(view: view)
            for subview in view.subviews.reversed() {
                stack.append(subview)
            }
        }
        
        return String(result.dropFirst())
    }
    
    func viewToCsvString(view: UIView) -> String {
        return ",1,\(view.frame.origin.x),\(view.frame.origin.y),\(view.frame.size.width),\(view.frame.size.height)"
    }
    
}

extension UIView {
    
    func touchHierarchy() -> [String] {
        var currentView = self
        var subviews = ["\(type(of: currentView))"]
        while let view = currentView.superview {
            subviews.append("\(type(of: view))")
            currentView = view
        }
        
        return subviews
    }
    
}

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
    
    class func topViewControllerDescription() -> String {
        if let topVC = topViewController() {
            return "\(type(of: topVC))"
        } else {
            return ""
        }
    }
    
}
