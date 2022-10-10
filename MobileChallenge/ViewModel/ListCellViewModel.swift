//
//  ListCellViewModel.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 14/10/20.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    private(set) var currency: CurrencyType
    
    init(currency: CurrencyType) {
        self.currency = currency
    }
    
    private func fillCell() {
        
    }
}
