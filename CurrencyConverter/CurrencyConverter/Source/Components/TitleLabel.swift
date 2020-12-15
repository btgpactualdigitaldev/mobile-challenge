//
//  TitleLabel.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        font = UIFont.systemFont(ofSize: 16, weight: .thin)
    }
    
}
