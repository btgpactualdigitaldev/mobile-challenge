//
//  Subtitle.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class SubtitleLabel: UILabel {
    
    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }

    // Methods

    private func style() {
        textAlignment = .center
        font = TextStyle.display5.font
        textColor = DesignSystem.Colors.secondary
    }
}
