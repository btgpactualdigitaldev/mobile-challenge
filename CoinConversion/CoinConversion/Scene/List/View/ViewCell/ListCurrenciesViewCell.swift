//
//  ListCurrenciesViewCell.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 20/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

class ListCurrenciesViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.setCardLayout()
        }
    }
    
    @IBOutlet private weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .colorGrayLighten60
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .colorGrayPrimary
        }
    }
    
    @IBOutlet private weak var currencyLabel: UILabel! {
        didSet {
            currencyLabel.textColor = .colorGrayPrimary
        }
    }
}

// MARK: - Public methods
extension ListCurrenciesViewCell {
    func bind(name: String, currency: String) {
        nameLabel.text = name
        currencyLabel.text = currency
    }
}
