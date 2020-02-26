//
//  CurrencyTableViewCell.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
