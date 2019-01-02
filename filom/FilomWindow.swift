//
//  FilomWindow.swift
//  filom
//
//  Created by Bastien Beurier on 9/17/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit


// ----------------------------------
// MARK: Window
// ----------------------------------


class FilomWindow: UIWindow {
    
    static let MAX_VIEWS = 300

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
        let viewList = self.viewList()
        logger.logToLine(writeString: topVCDesc + "," + viewList.0)
        
        let alert = UIAlertController(title: "", message: "Recorded \(viewList.1) views in \(topVCDesc).", preferredStyle: .alert)
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


// ----------------------------------
// MARK: Button
// ----------------------------------


class FilomButton: UIButton {
    
    private let size: CGFloat = 60.0
    private let margin: CGFloat = 10.0
    
    init() {
        let screenBounds = UIScreen.main.bounds
        super.init(frame: CGRect(x: screenBounds.size.width - size - margin,
                                 y: screenBounds.size.height - size - margin,
                                 width: size, height: size));
        
        backgroundColor = .blue
        layer.cornerRadius = size / 2
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
}


// ----------------------------------
// MARK: Logger
// ----------------------------------


class FilomLogger: NSObject {
    
    let logfileName = "filom"
    let logfileExtension = "csv"
    
    func logToLine(writeString: String) {
        let url = fileURL(fileName: logfileName, fileExtension: logfileExtension)
        do {
            try appendToURL(writeString: writeString + "\n", fileURL: url)
        } catch let error {
            print ("Failed writing to URL: \(fileURL), Error:" + error.localizedDescription)
        }
    }
}

extension FilomLogger {
    var DocumentDirURL: URL {
        let url = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return url
    }
    
    func fileURL(fileName: String, fileExtension: String)-> URL{
        return DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    }
    
    func appendToURL(writeString: String, fileURL: URL) throws {
        let data = writeString.data(using: String.Encoding.utf8)!
        try append(writeData: data, fileURL: fileURL)
    }
    
    func append(writeData: Data, fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(writeData)
        }
        else {
            let mutableData = NSMutableData(data: firstCsvLine().data(using: String.Encoding.utf8)!)
            mutableData.append(writeData)
            try mutableData.write(to: fileURL, options: .atomic)
        }
    }
    
    func firstCsvLine() -> String {
        let maxViewCount = FilomWindow.MAX_VIEWS
        var result = "screen"
        
        for i in 1...maxViewCount {
            result += ",view\(i),view\(i)X,view\(i)Y,view\(i)W,view\(i)H"
        }
        
        return result + "\n"
    }
}


// ----------------------------------
// MARK: Extensions
// ----------------------------------


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

extension UIWindow {
    
    // Depth-First Search to get the views from back to front.
    func viewList() -> (String, Int) {
        var stack: [UIView] = [self]
        var result = ""
        
        var viewCount = 0
        while let view = stack.popLast(), viewCount < FilomWindow.MAX_VIEWS {
            viewCount += 1
            result += viewToCsvString(view: view)
            for subview in view.subviews.reversed() {
                let className = "\(type(of: subview))"
                if className != String(describing: FilomButton.self) {
                    stack.append(subview)
                }
            }
        }
        
        return (String(result.dropFirst()), viewCount)
    }
    
    func viewToCsvString(view: UIView) -> String {
        return ",1,\(view.frame.origin.x),\(view.frame.origin.y),\(view.frame.size.width),\(view.frame.size.height)"
    }
    
}

