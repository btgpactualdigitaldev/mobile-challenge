//
//  CurrencyListViewModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

class CurrencyListViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var currencies: [CurrencyModel]
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    private(set) var showCurrencies: [CurrencyModel]
    
    var selectedCurrency: CurrencyModel?
    
    var numberOfRows: Int {
        return showCurrencies.count
    }
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(currencies: [CurrencyModel], selectedCurrency: CurrencyModel?) {
        self.currencies = currencies
        self.showCurrencies = currencies.sorted { $0.symbol < $1.symbol }
        self.selectedCurrency = selectedCurrency
    }
}


//*************************************************
// MARK: - Public Methods
//*************************************************

extension CurrencyListViewModel {
    
    func currencyCellViewModel(row index: Int) -> CurrencyCellViewModel {
        let currencyModel: CurrencyModel = showCurrencies[index]
        return CurrencyCellViewModel(currencyModel: currencyModel, selectedSymbol: selectedCurrency?.symbol.uppercased() ?? "")
    }
    
    func filter(searchText: String?, completion: (() -> Void)) {
        if let lowewSearchText: String = searchText?.lowercased(),
            !lowewSearchText.isEmpty {
            showCurrencies = currencies.filter { $0.symbol.lowercased().contains(lowewSearchText) || $0.descriptionCurrency.lowercased().contains(lowewSearchText) }
        } else {
            showCurrencies = currencies
        }
        showCurrencies = showCurrencies.sorted { $0.symbol < $1.symbol }
        completion()
    }
}
