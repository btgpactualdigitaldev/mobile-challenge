//
//  SupportedButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

// Class

final class SupportedButton: UIButton {

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        style()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = imageView else { return }
        imageEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width - 25), bottom: 5, right: 5)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageView.frame.width)
        
    }

    // Methods

    private func style() {
        titleLabel?.font = TextStyle.display3.font
        setTitleColor(DesignSystem.Colors.primary, for: .normal) 
        setTitle("moedas", for: .normal)
        setImage(DesignSystem.Icons.coins, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        clipsToBounds = false
    }
}
