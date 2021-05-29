//
//  CurrencyTableViewManager.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Class used to manage CurrencyTableView
class CurrencyTableViewManager: NSObject {
    
    weak var currencyListViewModel: CurrencyListViewModel?
    var sortType: sortType = .name
    var didSelectCurrency: ((CurrencyModel) -> Void)?
    var refreshSearch: (() -> Void)?
    var filteredCurrencies = [CurrencyModel]()
    var isFiltering = false
    
    init(currencyListViewModel: CurrencyListViewModel){
        self.currencyListViewModel = currencyListViewModel
    }
    
    /// Method to change the way data is sorted
    func changeOrder() {
        if sortType == .code {
            sortType = .name
        } else {
            sortType = .code
        }
    }
}
