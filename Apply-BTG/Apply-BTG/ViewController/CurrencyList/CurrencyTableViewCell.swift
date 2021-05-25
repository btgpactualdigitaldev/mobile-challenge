//
//  CurrencyTableViewCell.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 22/05/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.currencyNameLabel.font = UIFont(name: Constants.FONT_NAME,
                                   size: Constants.PICKER_VIEW_FONT_SIZE)
        self.currencyCodeLabel.font = UIFont(name: Constants.FONT_NAME,
                                             size: Constants.PICKER_VIEW_FONT_SIZE)                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
