//
//  BTGNumberTextField.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGNumberTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: .highlight).cgColor
        
        textColor = UIColor(named: .label)
        tintColor = UIColor(named: .label)
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontForContentSizeCategory = true
        
        backgroundColor = UIColor(named: .main)
        autocorrectionType = .no
        keyboardType = .decimalPad
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = PlaceholderText.textField.rawValue
    }
}
