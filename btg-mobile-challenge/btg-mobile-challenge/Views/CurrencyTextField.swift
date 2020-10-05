//
//  CurrencyTextField.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Representation of the app's custom `UITextField`.
/// It should be used in place of the default implementation.
final class CurrencyTextField: UITextField {

    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Styles the textfield.
    private func styleTextField() {
        keyboardType = .numberPad
        textAlignment = .center
        borderStyle = .roundedRect
    }
}
