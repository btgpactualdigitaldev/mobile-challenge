//
//  CurrencyTableViewManager+Delegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

extension CurrencyTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCurrencies.count : currencyListViewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        
        if isFiltering {
            cell.currency = filteredCurrencies[indexPath.row]
            return cell
        }
        
        guard let currencyList = currencyListViewModel else { return cell }
        
        if sortType == .code {
            cell.currency = currencyList.currenciesByCode[indexPath.row]
        } else {
            cell.currency = currencyList.currenciesByName[indexPath.row]
        }
        
        cell.setupViews()
        
        return cell
    }
}
