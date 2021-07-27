//
//  CurrencyTableViewCell.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 24/04/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    var currencyDescription = CurrencyDescription() {
        didSet {
            currencyDescriptionLabel.text = "\(currencyDescription.key) - \(currencyDescription.name)"
        }
    }

    @IBOutlet weak var currencyDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        currencyDescriptionLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
