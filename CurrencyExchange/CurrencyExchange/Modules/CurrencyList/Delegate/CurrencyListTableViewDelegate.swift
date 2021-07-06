//
//  CurrencyListTableViewDelegate.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelectCurrency: ((Currency) -> Void)?
    var currencies: [Currency]
    
    init(currencies: [Currency]){
        self.currencies = currencies
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        self.didSelectCurrency?(currency)
    }
}
