//
//  CurrencyButton.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Representation of the app's custom `UIButton`.
/// It should be used in place of the default implementation.
final class CurrencyButton: UIButton {

    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Styles the button.
    private func styleButton() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        layer.cornerRadius = DesignSpec.Button.cornerRadius
        backgroundColor = .systemRed
        clipsToBounds = true
    }
}
