//
//  CurrencySelectButton.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class CurrencySelectButton: BaseView {
    
    // MARK: - UI Components
    
    var primaryLabel = UILabel()
        .set(\.font, to: UIFont.systemFont(ofSize: 13, weight: .regular))
        .set(\.textColor, to: .white)
    
    var secondaryLabel = UILabel()
        .set(\.font, to: UIFont.systemFont(ofSize: 11, weight: .light))
        .set(\.textColor, to: .white)
    
    var chevronIcon = UIImageView()
        .set(\.tintColor, to: .white)
        .run {
            let thinConfiguration = UIImage.SymbolConfiguration(weight: .thin)
            $0.image = UIImage(systemName: "chevron.down", withConfiguration: thinConfiguration)?.withRenderingMode(.alwaysTemplate)
        }
    
    var tapAction: (() -> Void)?
    
    // MARK: - Setup
    
    override func initialize() {
        backgroundColor = .black
        layer.cornerRadius = 4
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapInside)))
    }
    
    override func addViews() {
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        addSubview(chevronIcon)
    }
    
    override func autoLayout() {
        primaryLabel
            .anchor(top: topAnchor, padding: 4)
            .anchor(leading: leadingAnchor, padding: 12)
        
        secondaryLabel
            .anchor(bottom: bottomAnchor, padding: 4)
            .anchor(leading: leadingAnchor, padding: 12)
        
        chevronIcon
            .anchor(centerY: centerYAnchor)
            .anchor(trailing: trailingAnchor, padding: 12)
        
        anchor(heightConstant: 40)
    }
    
    @objc private func didTapInside() {
        tapAction?()
    }
    
}
