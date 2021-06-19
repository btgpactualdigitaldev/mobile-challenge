//
//  CurrencyResultLabel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class CurrencyResultLabel: UILabel {

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }
    
    // Methods

    private func style() {
        textAlignment = .right
        font = TextStyle.display1.font
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        textColor = DesignSystem.Colors.secondary
        text = "1,00"
    }
}
