//
//  BTGSecondaryTitleLabel.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAlignment: NSTextAlignment = .left, fontSize: CGFloat) {
        self.init()
        let customFont = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: customFont)
        self.textAlignment = textAlignment
        
    }

    private func configure() {
        textColor = UIColor(named: .label)
        adjustsFontForContentSizeCategory = true
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
