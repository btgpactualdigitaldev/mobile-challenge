//
//  CurrencySearchViewModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

protocol CurrencySearchViewModelDelegate {
    func didGetCurrencies(_ currencies: Currencies)
    func didGetError(_ error: Error)
}

class CurrencySearchViewModel: ViewModel {
    
    var viewController: UIViewController?
    var service: CurrencySearchService = CurrencySearchService()
    
    required init() {
        service.viewModel = self
    }
    
    func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getAvailableCurrencies() {
        service.getAvailableCurrencies()
    }
    
    func didPickCurrency(_ currency: (String, String)) {
        let controller = viewController as! CurrencySearchViewController
        if controller.isSourceCurrencyActionCaller {
            CurrentAppState.shared.setSourceCurrentCurrency(Dictionary(dictionaryLiteral: currency))
        } else {
            CurrentAppState.shared.setDestinyCurrentCurrency(Dictionary(dictionaryLiteral: currency))
        }
    }
    
}

extension CurrencySearchViewModel: CurrencySearchViewModelDelegate {
    func didGetCurrencies(_ currencies: Currencies) {
        print(currencies)
        (viewController as! CurrencySearchViewController).setCurrencies(currencies)
    }
    
    func didGetError(_ error: Error) {
        
    }
}
