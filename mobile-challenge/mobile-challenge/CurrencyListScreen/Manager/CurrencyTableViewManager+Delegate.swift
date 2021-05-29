//
//  CurrencyTableViewManager+Delegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

extension CurrencyTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isFiltering {
            didSelectCurrency?(filteredCurrencies[indexPath.row])
            return
        }
        
        guard let currencyList = currencyListViewModel else { return }
        if sortType == .code {
            didSelectCurrency?(currencyList.currenciesByCode[indexPath.row])
        } else {
            didSelectCurrency?(currencyList.currenciesByName[indexPath.row])
        }
    }
}
