//
//  UserPathViewController.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

import SnapKit

class UserPathViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView()
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(20)
        }
        
        if FilomData.states.count > 0 {
            imageView.image = FilomData.states[0].image
        }
    }

}
