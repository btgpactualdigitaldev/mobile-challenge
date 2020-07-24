//
//  BTGSelectionButton.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGSelectionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor = UIColor(named: .main), title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: .highlight).cgColor
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.lineBreakMode = .byTruncatingMiddle
        setTitleColor(UIColor(named: .label), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor = UIColor(named: .main), title: String)
    {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
