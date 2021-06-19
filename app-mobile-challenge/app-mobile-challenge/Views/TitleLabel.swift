//
//  TitleLabel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class TitleLabel: UILabel {
    
    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }
    
    // Methods

    private func style() {
        textAlignment = .center
        font = TextStyle.display2.font
        textColor = DesignSystem.Colors.secondary
    }
}
