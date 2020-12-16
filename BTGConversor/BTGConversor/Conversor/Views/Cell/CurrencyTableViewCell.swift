//
//  CurrencyTableViewCell.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/14/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak private var currencyCodeLabel: UILabel!
    @IBOutlet weak private var currencyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(_ currency: (String, String)) {
        currencyCodeLabel.text = currency.0
        currencyNameLabel.text = currency.1
    }
    
}
