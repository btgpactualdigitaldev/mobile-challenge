//
//  CurrencyCell.swift
//  TrocaMoeda
//
//  Created by mac on 26/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
