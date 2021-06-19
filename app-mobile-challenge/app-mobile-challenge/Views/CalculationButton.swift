//
//  CalculationButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class CalculationButton: UIButton {
    
    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }

    // Methods

    private func style() {
        titleLabel?.font = TextStyle.display3.font
        setTitleColor(DesignSystem.Colors.background, for: .normal)
        setTitle("Calcular", for: .normal)
        let icon = DesignSystem.Backgrounds.gradientButton
        backgroundImage(for: .normal)
        setBackgroundImage(icon, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 24
    }
}
