//
//  AvailableCurrencyCell.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//
//* Uma lista das moedas disponíves para conversão, mostrando código e nome da moeda.

import UIKit

internal class AvailableCurrencyCell: UITableViewCell {

    internal var currencyCode: UILabel!
    internal var currencyName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        currencyCode = UILabel()
        currencyName = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AvailableCurrencyCell: ViewCodable {

    func buildView() {
        addSubview(currencyName)
        addSubview(currencyCode)
    }

    func setupConstraints() {
        currencyName.translatesAutoresizingMaskIntoConstraints = false
        currencyCode.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyCode.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            currencyCode.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyCode.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            currencyName.leadingAnchor.constraint(equalTo: currencyCode.trailingAnchor, constant: 16),
            currencyName.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }

    func setupAdditionalConfig() {
        
    }

    func render() {
        
    }

}
