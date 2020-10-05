//
//  CurrencyResultLabel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Representation of one of the app's custom `UILabel`.
/// It should **only** be used when displaying results from a conversion.
/// If displaying a label for any other purpose, use `CurrencyLabel` instead
/// of the default implementation.
final class CurrencyResultLabel: UILabel {

    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Styles the label.
    private func styleLabel() {
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        textColor = .white
        backgroundColor = .systemRed
    }
}
