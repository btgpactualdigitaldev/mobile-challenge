//
//  CurrenciesViewModel.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 05/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation

final class CurrenciesViewModel {
    
    private let coordinator: ConverterCoordinatorProtocol
    private var currencies: [Currency]
    var type: ActionType
    private var searchText = ""
    
    var filterCurrencies: [Currency] {
        return searchText.isEmpty ? currencies : currencies.filter {
            $0.code.containsIgnoringCase(text: searchText) || $0.code.containsIgnoringCase(text: searchText)
        }
    }
    
    init(coordinator: ConverterCoordinatorProtocol, currencies: [Currency], type: ActionType) {
        self.coordinator = coordinator
        self.currencies = currencies
        self.type = type
    }
    
    public var numberOfItems: Int {
        return filterCurrencies.count
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
    public func filterBy(text: String) {
       self.searchText = text
    }
    
    public func back() {
        coordinator.back()
    }
    
    public var baseCurrency: String {
        return UserDefaults.LCurrency.baseCurrency
    }
    
    public func findCurrencyBy(indexPath: IndexPath) -> Currency {
        return filterCurrencies[indexPath.row]
    }
    
    public func update(currency: Currency) {
        switch type {
        case .changeBaseCurrency:
            UserDefaults.LCurrency.baseCurrency = currency.code
        case .addNewCurrency:
            let allCurrencies = UserDefaults.LCurrency.lives
            let allFavotitedCurrencies = UserDefaults.LCurrency.favoritedCurrencies
            if let favoritedCurrency = allCurrencies.first(where: {$0.code == currency.code}) {
                if allFavotitedCurrencies.contains(where: {$0.code == favoritedCurrency.code }) {
                    break
                }
                UserDefaults.LCurrency.favoritedCurrencies.append(favoritedCurrency)
            }                      
        }
        back()
    }
}

extension CurrenciesViewModel {
    enum ActionType {
        case changeBaseCurrency
        case addNewCurrency
    
        var title: String {
            switch self {
            case .changeBaseCurrency:
                return "Select Base Currency"
            case .addNewCurrency:
                return "Select New Currency"
            }
        }
    }
}

extension String {
    
    func containsIgnoringCase(text: String) -> Bool {
        return (self.range(of: text, options: .caseInsensitive) != nil)
    }
}
