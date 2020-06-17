//
//  CurrencyCell.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 17/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet var currencyLabel: UILabel!
    
    func setup(code:String, name: String, selected: Bool) {
        self.accessoryType = selected ? .checkmark : .none
        self.isSelected = selected
        
        self.currencyLabel.text = "\(code): \(name)"
    }
}
