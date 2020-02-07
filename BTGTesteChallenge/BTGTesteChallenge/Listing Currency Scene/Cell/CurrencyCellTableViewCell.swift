//
//  CurrencyCellTableViewCell.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import UIKit

class CurrencyCellTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCellContent(code: String, description: String) {
        currencyCodeLabel.text = code
        currencyDescriptionLabel.text = description
    }
    
    
}
