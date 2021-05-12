//
//  CurrencySelectionTableViewCell.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 08/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import UIKit

class CurrencySelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var currency: Currency?
   
    func setup(_ currency: Currency?) {
        self.currency = currency
        self.symbolLabel.text = currency?.symbol
        self.nameLabel.text = currency?.name
    }
}
