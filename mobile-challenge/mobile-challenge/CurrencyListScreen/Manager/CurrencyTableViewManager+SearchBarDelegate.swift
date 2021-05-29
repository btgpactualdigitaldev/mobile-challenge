//
//  CurrencyTableViewManager+SearchBarDelegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

extension CurrencyTableViewManager: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isFiltering = false
            return
        } else {
            isFiltering = true
        }
        
        guard let currencyList = currencyListViewModel else { return }
        var currenciesAr = [CurrencyModel]()
        
        if sortType == .code {
            currenciesAr = currencyList.currenciesByCode
        } else {
            currenciesAr = currencyList.currenciesByName
        }
        
        filteredCurrencies = currenciesAr.filter { (currency) -> Bool in
            return currency.name.lowercased().contains(searchText.lowercased()) || currency.code.lowercased().contains(searchText.lowercased())
        }
        
        refreshSearch?()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
        refreshSearch?()
    }
    
}
