//
//  CurrencyButtonView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class BackButtonView: UIButton {
    
    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }

    // Methods
    
    private func style() {
        let icon = DesignSystem.Icons.back
        setImage(icon, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        clipsToBounds = true
    }
}
