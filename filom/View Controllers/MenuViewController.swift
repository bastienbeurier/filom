//
//  MenuViewController.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
        FilomData.clear()
        if let window = UIApplication.shared.keyWindow as? FilomWindow {
            window.startMonitoring()
        }
    }
    
}
