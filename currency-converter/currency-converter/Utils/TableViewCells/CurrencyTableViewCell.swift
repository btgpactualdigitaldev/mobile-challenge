//
//  CurrencyTableViewCell.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import UIKit


class CurrencyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblInitials: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with currency: CurrencyInfo) {
        
        lblInitials.text = currency.initial
        lblCountry.text = currency.fullName
        
    }
    
}
