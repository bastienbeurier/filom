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

    let logger = FilomLogger()
    let recordButton: FilomButton = {
        let button = FilomButton()
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func startMonitoring() {
        toggleRecordButton(isShowing: true)
    }
    
    func stopMonitoring() {
        toggleRecordButton(isShowing: false)
    }
    
    func notifyNewStep() {
        guard let currentHierarchy = self.currentHierarchy else { return }
        print(currentHierarchy)
        FilomData.states.append(currentHierarchy)
    }

    func toggleRecordButton(isShowing: Bool) {
        if isShowing {
            
        } else {
            
        }
    }
    
}

extension FilomWindow {
    
    @objc func recordButtonTapped(sender : UIButton){
        notifyNewStep()
    }
    
}
