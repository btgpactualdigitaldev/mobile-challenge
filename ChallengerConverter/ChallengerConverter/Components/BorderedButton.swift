//
//  BorderedButton.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation
import UIKit


class BorderedButton: UIButton {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupUI()
    }
    
}


extension BorderedButton {
    func setupUI() {
        
        clipsToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 20
    }
}
