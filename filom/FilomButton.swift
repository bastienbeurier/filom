//
//  FilomButton.swift
//  filom
//
//  Created by Bastien Beurier on 1/2/19.
//  Copyright © 2019 Bastien Beurier. All rights reserved.
//

import UIKit

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
