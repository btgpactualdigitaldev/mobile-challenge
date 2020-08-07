//
//  CurrencyViewCell.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 04/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class CurrencyViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    func setCurrency(_ currency: Currency) {
        title.text = "\(currency.abbreviation) - \(currency.name)"
    }
}
