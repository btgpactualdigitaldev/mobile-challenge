//
//  CurrencyCell.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    //TODO: Implement image with flag country
    @IBOutlet private weak var flagImage: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        flagImage.round()
    }
    
    func setup(viewModel: CurrencyCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptionCurrency
        
        accessoryType = viewModel.isSelected ? .checkmark : .none
    }
}
