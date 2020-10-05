//
//  CurrencyLabel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Representation of one of the app's custom `UILabel`.
/// It should be used in place of the default implementation.
/// If displaying a result from a conversion, use `CurrencyResultLabel`.
final class CurrencyLabel: UILabel {

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
    }

}
