//
//  BTGConverterCardItem.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

enum ConverterItemType {
    case base
    case target
}

class BTGConverterCardItem: UIView {
    
    let selectCurrencyButton = BTGButton(backgroundColor: .systemGreen, title: "+")
    let titleLabel = BTGTitleLabel(textAlignment: .left, fontSize: 26)
    let currencyLabel = BTGSecondaryTitleLabel(fontSize: 46)
    
    private let verticalPadding : CGFloat = 10
    private let horizontalPadding : CGFloat = 10
    
    init(itemType: ConverterItemType) {
        super.init(frame: .zero)
        configure(itemType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ itemType: ConverterItemType) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 13
        backgroundColor = .systemGray4
        
        configureTitleLabel()
        configureCurrencyLabel()
        configureSelectCurrencyButton()
        configureItemType(itemType)
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        ])
    }
    
    private func configureCurrencyLabel() {
        addSubview(currencyLabel)
        currencyLabel.backgroundColor = .systemGray4
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = .secondaryLabel
        currencyLabel.font = UIFont.systemFont(ofSize: 46, weight: .bold)
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -verticalPadding),
            currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            currencyLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65),
            currencyLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        ])
    }
    
    private func configureSelectCurrencyButton() {
        addSubview(selectCurrencyButton)
        
        selectCurrencyButton.backgroundColor = .tertiarySystemBackground
        selectCurrencyButton.titleLabel?.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        
        NSLayoutConstraint.activate([
            selectCurrencyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            selectCurrencyButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            selectCurrencyButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            selectCurrencyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureItemType(_ itemType: ConverterItemType) {
        switch itemType {
        case .base:
            self.titleLabel.text = ViewsConstants.BTGConverterCardItemBaseTitle.rawValue
        case .target:
            self.titleLabel.text = ViewsConstants.BTGConverterCardItemBaseTargetTitle.rawValue
        }
    }
}
