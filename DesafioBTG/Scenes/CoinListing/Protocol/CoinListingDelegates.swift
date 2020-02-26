//
//  CoinListingDelegates.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

protocol CoinListingBusinessDelegate {
    func fetchCurrencies()
    func orderCurrenciesByCode(currencies: [CoinListing.Currencies.Currency])
    func orderCurrenciesByName(currencies: [CoinListing.Currencies.Currency])
    func selected(currency: CoinListing.Currencies.Currency, from: CurrencySelected)
    func getCurrencySelected()
    func searchCurrency(text: String)
}

protocol CoinListingDisplayDelegate: class {
    func displayCurrencies(viewModel: CoinListing.Currencies.ViewModel)
    func displayErrorInFetchCurrencies()
    func displaySourceCurrency()
    func displayToCurrency()
    func setCurrencySelected(currencySelected: CurrencySelected?)
}

protocol CoinListingPresentationDelegate {
    func presentCurrencies(currencies: [CoinListing.Currencies.Currency])
    func presentErrorInFetchCurrencies()
    func presentSelectedSourceCurrency()
    func presentSelectedToCurrency()
    func presentCurrencySelected(currencySelected: CurrencySelected?)
}

@objc protocol CoinListingRoutingDelegate {
    func routeToConversion(segue: UIStoryboardSegue?)
    func routeToConversionSourceCurrency(segue: UIStoryboardSegue?)
    func routeToConversionToCurrency(segue: UIStoryboardSegue?)
}

protocol CoinListingDataPassing {
    var dataStore: CoinListingDataStore? { get }
}

protocol CoinListingDataStore {
    var currencies: [CoinListing.Currencies.Currency]? { get set }
    var currency: CoinListing.Currencies.Currency? { get }
    var currencySelected: CurrencySelected? { get set }
}
