//
//  SelectCurrencyButton.swift
//  mobile-challenge
//
//  Created by gabriel on 02/12/20.
//

import UIKit

public enum CurrencyType {
    case origin
    case destiny
}

class SelectCurrencyButton: UIButton {
    
    let type: CurrencyType
    
    init(ofType type: CurrencyType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        self.backgroundColor = .systemGray6
        self.setTitleColor(.systemGray, for: .normal)
        self.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
