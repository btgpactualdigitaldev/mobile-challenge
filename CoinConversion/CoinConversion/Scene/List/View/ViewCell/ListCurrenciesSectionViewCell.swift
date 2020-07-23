//
//  ListCurrenciesSectionViewCell.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

protocol ListCurrenciesSectionViewCellDelegate: class {
    func didTapSortBy(_ sortType: SortType)
}

// MARK: - Main
class ListCurrenciesSectionViewCell: UITableViewHeaderFooterView {
    @IBOutlet weak var sortByNameButton: RadioButton! {
        didSet {
            sortByNameButton.iconColor = .colorGrayLighten60
            sortByNameButton.indicatorColor = .colorDarkishPink
            sortByNameButton.iconBackgroundColor = .colorGrayLighten70
        }
    }
    
    @IBOutlet private weak var sortByCodeButton: RadioButton! {
        didSet {
            sortByCodeButton.iconColor = .colorGrayLighten60
            sortByCodeButton.indicatorColor = .colorDarkishPink
            sortByCodeButton.iconBackgroundColor = .colorGrayLighten70
        }
    }
    
    @IBAction private func didTapSortByNameButton(_ sender: RadioButton) {
        setupRadioButtons(tag: 0, buttons: sortByNameButton)
        delegate?.didTapSortBy(.name)
    }
    
    @IBAction private func didTapSortByCodeButton(_ sender: RadioButton) {
        setupRadioButtons(tag: 1, buttons: sortByNameButton)
        delegate?.didTapSortBy(.code)
    }
    
    weak var delegate: ListCurrenciesSectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .colorBackground
    }
}

// MARK: - Radio buttons
extension ListCurrenciesSectionViewCell {
    func setupRadioButtons(tag: Int, buttons: RadioButton) {
        buttons.isMultipleSelectionEnabled = false
        
        buttons.allButtons().forEach { button in
            button.isSelected = tag == button.tag
        }
    }
}
