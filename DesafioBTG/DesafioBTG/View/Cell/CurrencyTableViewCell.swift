//
//  CurrencyTableViewCell.swift
//  DesafioBTG
//
//  Created by Any Ambria on 13/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var codeLabel: UILabel?
    
    static let reuseId = "CurrencyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(name: String, code: String) {
        nameLabel?.text = name
        codeLabel?.text = code
    }
    
}
