//
//  CurrencyUiTableViewCell.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import UIKit

class CurrencyUiTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(currency: Currency) {
        textLabel?.text = "\(currency.code) - \(currency.description)"
    }
    
}
