//
//  BTGListViewCell.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGListViewCell: UITableViewCell {
    static let reuseID = CellIds.listView.rawValue
    let nameLabel = BTGSecondaryTitleLabel(fontSize: 20)
    let symbolLabel = BTGBodyLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(currency: Currency) {
        nameLabel.text = currency.name
        symbolLabel.text = currency.symbol
    }
    
    private func configure() {
        addSubviews(nameLabel, symbolLabel)
        backgroundColor = UIColor(named: .background)
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(named: .accent)
        selectedBackgroundView = selectedView
        let padding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            symbolLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}
