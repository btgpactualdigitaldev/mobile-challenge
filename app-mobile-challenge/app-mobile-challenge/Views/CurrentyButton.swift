//
//  SupportedButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class CurrentyButton: UIButton {

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }
    
    // Methods

    private func style() {
        titleLabel?.font = TextStyle.display1.font
        setTitleColor(DesignSystem.Colors.primary, for: .normal)
        setTitle("USD", for: .normal)
        clipsToBounds = true
    }
}
