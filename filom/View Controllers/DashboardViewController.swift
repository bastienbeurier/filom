//
//  DashboardViewController.swift
//  filom
//
//  Created by Bastien Beurier on 9/10/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
                
        #if targetEnvironment(simulator)
        if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            print("Documents Directory: \(documentsPath)")
        }
        #endif
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

// MARK: Actions

extension DashboardViewController {
    
    @IBAction func buttonPressed(_ sender: UIButton) {
//        print("Action performed")
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
//        print("Action performed")
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
//        print("Action performed")
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
//        print("Action performed")
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
//        print("Action performed")
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
//        print("Action performed")
    }
    
}
