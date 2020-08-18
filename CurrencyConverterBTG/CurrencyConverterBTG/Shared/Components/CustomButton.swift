//
//  CustomButton.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case normal
    case line
}

class CustomButton: UIButton {
    
    
    // MARK: - Public Properties
    
    
    override var isHighlighted: Bool {
        didSet {
            layer.borderColor = isHighlighted ? highlightedBorderColor : borderColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.5
        }
    }
    
    
    // MARK: - Private Properties
    
    
    private var borderColor: CGColor? {
        didSet {
            layer.borderColor = borderColor
            self.setNeedsDisplay()
        }
    }
    
    private var highlightedBorderColor: CGColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    // MARK: - Inits
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - Public Methods


extension CustomButton {
    func configure(style: ButtonStyle) {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        cornerRadius = 4
        switch style {
        case .normal:
            setTitleColor(.white, for: .normal)
            setTitleColor(.white, for: .highlighted)
            setTitleColor(.white, for: .disabled)
            
            layer.borderWidth = 0
            borderColor = UIColor.clear.cgColor
            highlightedBorderColor = UIColor.clear.cgColor
            backgroundColor = .green
        case .line:
            setTitleColor(UIColor(hexadecimal: 0x2A6CB4), for: .normal)
            setTitleColor(.red, for: .highlighted)
            setTitleColor(UIColor(hexadecimal: 0xC8D9EB), for: .disabled)
            
            layer.borderWidth = 1
            borderColor = UIColor.green.cgColor
            highlightedBorderColor = UIColor(hexadecimal: 0xC8D9EB).cgColor
        }
        
        
        
        
    }
}
