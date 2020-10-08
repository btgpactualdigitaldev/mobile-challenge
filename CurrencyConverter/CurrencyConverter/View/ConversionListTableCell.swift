//
//  ConversionListTableCell.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit

class ConversionListTableCell: UITableViewCell {

    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var coinNameLabel: UILabel!
    
    static let cellIdentifier = "ConversionListTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ConversionListTableCell", bundle: nil)
    }
    
    public func configure(with viewModel: CoinViewModel) {
        initialsLabel.text = viewModel.initials
        coinNameLabel.text = viewModel.name
    }
    
}
