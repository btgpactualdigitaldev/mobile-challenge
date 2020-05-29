//
//  CurrencyCell.swift
//  Desafio BTG
//
//  Created by Vinícius Brito on 25/05/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    
    var currency = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - <Methods>
    
    func setup(currency: String) {
        currencyLabel.text = "\(currency)"
    }
    
}
