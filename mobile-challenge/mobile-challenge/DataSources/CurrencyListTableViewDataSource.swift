//
//  CurrencyListTableViewDataSource.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: Bindings
    var numberOfRows: ((Int) -> Int) = { _ in return 0 }
    var currencyForRow: ((Int) -> Currency?) = { _ in return nil }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currency = currencyForRow(indexPath.row) else {
            return UITableViewCell()
        }
        
        let name = currency.name
        let symbol = currency.symbol
        
        let cell = CurrencyTableViewCell()
        cell.setup(for: name, and: symbol)
                
        return cell
    }
}
