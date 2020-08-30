//
//  MoedasTableViewCell.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 26/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import UIKit

class MoedasTableViewCell: UITableViewCell {

    @IBOutlet weak var moedaLabel: UILabel!
    @IBOutlet weak var siglaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
