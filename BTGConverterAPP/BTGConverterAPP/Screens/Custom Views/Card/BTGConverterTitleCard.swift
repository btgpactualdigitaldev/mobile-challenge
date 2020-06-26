//
//  BTGConverterTitleCard.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class BTGConverterTitleCard: UIView {
    
    var titleLabel = BTGTitleLabel(textAlignment: .left, fontSize: 33)
    var lastTimeUpdatedLabel = BTGSecondaryTitleLabel(frame: .zero)
    var shareButton = BTGButton()
    private let verticalPadding : CGFloat = 10
    private let horizontalPadding : CGFloat = 10
    private var lastUpdated : String = ""
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureTitleLabel()
        configureLastUpdatedLabel()
        configureShareButton()
    }
    
    func configureShareButton() {
        addSubview(shareButton)
        shareButton.titleLabel?.text = "?"
        shareButton.backgroundColor = .systemBackground
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .black, scale: .large )
        let symbol = UIImage(systemName: SFSymbolsConstants.squareAndArrowUp.rawValue)
        shareButton.setImage(symbol, for: .normal)
        shareButton.tintColor = .systemGray
        shareButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            shareButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = ViewsConstants.BTGConverterTitleCardTitle.rawValue
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func configureLastUpdatedLabel() {
        
        addSubview(lastTimeUpdatedLabel)
        lastTimeUpdatedLabel.backgroundColor = .systemBackground
        lastTimeUpdatedLabel.textColor = .systemGreen
        
        NSLayoutConstraint.activate([
            lastTimeUpdatedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2),
            lastTimeUpdatedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            lastTimeUpdatedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            lastTimeUpdatedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        ])
    }
    
}
