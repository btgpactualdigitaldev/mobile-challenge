//
//  BTGBodyLabel.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textColor = UIColor(named: .secondaryLabel)
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
