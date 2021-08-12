//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 14/12/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
