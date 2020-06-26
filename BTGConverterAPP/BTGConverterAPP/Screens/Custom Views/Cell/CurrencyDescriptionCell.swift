//
//  CurrencyDescriptionCell.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class CurrencyDescriptionCell: UITableViewCell {
    
    static let reuseID = "currencyID"
    let currencyDescriptionLabel = BTGTitleLabel(textAlignment: .left, fontSize: 16)
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ currencyDescription: CurrencyDescription) {
        currencyDescriptionLabel.text = "\(currencyDescription.abbreviation) - \(currencyDescription.fullDescription)"
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 8
        
        addSubview(currencyDescriptionLabel)
        
        NSLayoutConstraint.activate([
            currencyDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            currencyDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            currencyDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            currencyDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currencyDescriptionLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
