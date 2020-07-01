//
//  CurrencyCellViewModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

class CurrencyCellViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let currencyModel: CurrencyModel
    private let selectedSymbol: String
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var title: String {
        return currencyModel.symbol.uppercased()
    }
    
    var descriptionCurrency: String {
        return currencyModel.descriptionCurrency
    }
    
    var isSelected: Bool {
        return currencyModel.symbol.uppercased() == selectedSymbol
    }
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(currencyModel: CurrencyModel, selectedSymbol: String) {
        self.currencyModel = currencyModel
        self.selectedSymbol = selectedSymbol
    }
    
}
