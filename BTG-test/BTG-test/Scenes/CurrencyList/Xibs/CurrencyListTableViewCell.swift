//
//  CurrencyListTableViewCell.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    static let reuseIdentifier = String(describing: type(of: self))
    
    var viewModel: ViewModel? {
        didSet {
            didSetViewModel()
        }
    }
    
    
    private func didSetViewModel() {
        guard let viewModel = viewModel else { return }
        currencyLabel.text = {
            if let description = viewModel.currencyDescription {
                return "\(viewModel.currencyTitle) - \(description)"
            } else {
                return viewModel.currencyTitle
            }
        }()
    }
    
}

extension CurrencyListTableViewCell {
    struct ViewModel {
        var currencyTitle: String
        var currencyDescription: String?
    }
}
