//
//  BtgTextField.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgTextField: UITextField {

    init() {
        super.init(frame: .zero)
        
        textColor = .darkGray
        keyboardType = .numberPad
        if let font = UIFont.btgLabelLarge() {
            self.font = font
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
