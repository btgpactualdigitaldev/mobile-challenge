//
//  CurrencyCell.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 27/09/21.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var lblCurrencyID: UILabel!
    @IBOutlet weak var lblCurrencyDescription: UILabel!
    
    // MARK: - Public properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Public methods
    
    func setup(with currency: Currency) {
        lblCurrencyID.text = currency.id
        lblCurrencyDescription.text = currency.description
    }
    
}
