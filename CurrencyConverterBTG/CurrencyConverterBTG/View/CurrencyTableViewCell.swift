//
//  CurrencyTableViewCell.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "currencyCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = DesignSystem.Color.darkPrimary
        self.textLabel?.textColor = DesignSystem.Color.white
        self.detailTextLabel?.textColor = DesignSystem.Color.moneySign
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
