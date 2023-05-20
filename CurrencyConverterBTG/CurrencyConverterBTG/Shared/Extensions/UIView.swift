//
//  UIView.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import UIKit

extension UIView {
    
    
    // MARK: - Public Properties
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    // MARK: - Public Methods
    
    
    func round() {
        cornerRadius = frame.size.width / 2
        layer.masksToBounds = cornerRadius > 0
    }
    
    func dropShadow(scale: Bool = true, color: UIColor = UIColor.black) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
