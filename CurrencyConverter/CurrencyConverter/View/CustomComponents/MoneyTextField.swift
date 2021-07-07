//
//  MoneyTextField.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class MoneyTextField: UITextField {
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.placeholder = "0"
        self.textAlignment = .right
        self.borderStyle = .roundedRect
        self.returnKeyType = .done
        self.keyboardType = .numberPad
    }
}
