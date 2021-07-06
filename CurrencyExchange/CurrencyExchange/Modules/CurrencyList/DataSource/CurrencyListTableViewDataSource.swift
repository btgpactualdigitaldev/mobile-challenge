//
//  CurrencyListTableViewDataSource.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var currencies: [Currency]
    
    init(currencies: [Currency]){
        self.currencies = currencies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListTableViewCell.uniqueIdentifier, for: indexPath) as? CurrencyListTableViewCell else {
            return UITableViewCell()
        }
        
        let currency = currencies[indexPath.row]
        
        cell.setupCurrencyWithName(currency.name, withShortName: currency.code)
        
        return cell
    }
    
    
}
