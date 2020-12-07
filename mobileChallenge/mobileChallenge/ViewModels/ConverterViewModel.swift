//
//  ConverterViewModel.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit

final class ConverterViewModel {
    
    private let coordinator: ConverterCoordinator
    
    var favoritedCurrencies: [Live] {
        return UserDefaults.LCurrency.favoritedCurrencies
    }
    
    init(coordinator: ConverterCoordinator) {
        self.coordinator = coordinator
    }
    
    var title: String {
        return "Converter currency"
    }
    
    public func showCurrencies(type: CurrenciesViewModel.ActionType) {
        coordinator.showCurrencies(type: type)
    }
    
    public var titleCurrencyButton: String {
        return UserDefaults.LCurrency.baseCurrency
    }
    
    public func baseCurrency() -> Live? {
        let code = UserDefaults.LCurrency.baseCurrency
        return Live.findBy(code: code)
    }
    
    public var numberOfItems: Int {
        return favoritedCurrencies.count
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
}
