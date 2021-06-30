//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import Foundation

class CurrencyListViewModel {
    
    // MARK: Coordinator
    weak var coordinator: CurrencyListCoordinator?
    
    // MARK: Dependencies
    private let currencyList: CurrencyList
        
    // MARK: Delegates
    weak var delegate: CurrencyListViewModelDelegate?
    
    // MARK: Variables
    // Filtered obtained from currencyList
    private var filteredCurrencyList: [Currency]
    
    let type: CurrencyType
    
    var numberOfRows: Int {
        return filteredCurrencyList.count
    }
    
    // MARK: Init
    init(currencyList: CurrencyList, type: CurrencyType) {
        self.currencyList = currencyList
        self.filteredCurrencyList = currencyList.currencies
        self.type = type
    }
    
    // MARK: Methods
    /**
     The filtered currency for the specified row.
     
     - Parameter row: The currency's target index.
     */
    func getCurrency(for index: Int) -> Currency {
        return filteredCurrencyList[index]
    }
    
    /**
     Filter currencies by name or symbol.
     
     - Parameter text: The text to compare.
     */
    func filter(by text: String) {
        let filtered = currencyList.currencies.filter({
            // Query by name or symbol
            $0.name.lowercased().contains(text) || $0.symbol.lowercased().contains(text)
        })
        self.filteredCurrencyList = filtered.isEmpty ? currencyList.currencies : filtered
        
        delegate?.dataChanged()
    }
    
    /**
     Asks the coordinator to deal with the transition for a selected currency.
     
     - Parameter index: Index of the selected currency.
     */
    func currencySelected(at index: Int) {
        let currency = filteredCurrencyList[index]
        coordinator?.currencySelected(currency)
    }
}
