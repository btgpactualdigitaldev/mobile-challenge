//
//  CurrencyListViewModel.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import UIKit

class CurrencyListViewModel {
    
    weak var coordinator: MainCoordinator?
    
    static private let currenciesStorageString = "Currencies"
    
    private var currencies = [Currency]() {
        didSet {
            filterCurrencies(search: searchString)
        }
    }
    
    private var searchString = ""
    
    var filteredCurrencies = [Currency]() {
        didSet {
            viewController?.update()
        }
    }
    
    var rowsInSection: Int {
        return filteredCurrencies.count
    }
    
    weak var viewController: CurrencyListViewController?
    
    func updateCurrencies() {
        CurrencyLayerAPI.shared.fetchSupportedCurrencies { [unowned self] result in
            switch result {
            case .success(let currenciesDTO):
                self.currencies = currenciesDTO.currencies.sorted(by: { (c1, c2) -> Bool in
                    c1.code < c2.code
                })
                Debugger.log("Saving currencies to User Defaults")
                LocalStorage.store(currencies: currencies)
            case .failure(let error):
                switch error {
                case NetworkingError.transportError:
                    if let storedCurrencies = LocalStorage.retrieveCurrencies() {
                        Debugger.log("Retrieving currencies from User Defaults")
                        currencies = storedCurrencies
                    } else {
                        Debugger.log("There was a problem on your internet connection")
                        guard let viewController = viewController else { return }
                        coordinator?.showConnectionProblemAlert(error: error, sender: viewController, handler: {
                            viewController.dismiss(animated: true, completion: nil)
                        })
                    }
                default:
                    Debugger.log(error.rawValue)
                }
            }
        }
    }
    
    func filterCurrencies(search: String?) {
        guard let search = search else { return }
        if search == "" {
            filteredCurrencies = currencies
        } else {
            let filtered = currencies.filter({ (currency) -> Bool in
                currency.name.contains(search) || currency.code.contains(search.uppercased())
            })
            filteredCurrencies = filtered
        }
        searchString = search
    }
    
    func selectCurrency(currency: Currency) {
        coordinator?.selectCurrency(currency: currency)
    }
}
