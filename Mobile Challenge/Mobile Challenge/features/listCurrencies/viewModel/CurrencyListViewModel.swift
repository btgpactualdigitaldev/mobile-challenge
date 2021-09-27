//
//  CurrencyListViewModel.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

final class CurrencyListViewModel {
    
    // MARK: - Private properties
    
    private var currencyListUseCase: ListCurrenciesUseCase
    private var backupCurrencyList: [Currency]?
    
    // MARK: - Binding properties
    
    var currencyList: [Currency]? {
        didSet {
            guard let currencyList = currencyList else { return }
             
            NotificationCenter.default.post(name: NSNotification.Name(Constants.CurrencyListNotificationName.rawValue), object: currencyList)
            
            if backupCurrencyList == nil {
                backupCurrencyList = currencyList
            }
        }
    }
    
    private var listCurrencyError: Error? {
        didSet {
            guard let listCurrencyError = listCurrencyError else { return }
            
            NotificationCenter.default.post(name: NSNotification.Name(Constants.CurrencyListErrorNotificationName.rawValue), object: listCurrencyError)
        }
    }
    
    // MARK: - Initializer
    
    init(currencyListUseCase: ListCurrenciesUseCase) {
        self.currencyListUseCase = currencyListUseCase
    }
    
    // MARK: - Public methods
    
    func list() {
        currencyListUseCase.list { currencies, error in
            if let error = error {
                self.listCurrencyError = error
                return
            }
            
            self.currencyList = currencies
        }
    }
    
    func search(for textToSearch: String?) {
        guard let textToSearch = textToSearch, !textToSearch.isEmpty else {
            currencyList = backupCurrencyList
            return
        }
        
        currencyList = backupCurrencyList?.filter({ currency in
            currency.id.lowercased().contains(textToSearch.lowercased()) || currency.description.lowercased().contains(textToSearch.lowercased())
        })
    }
    
}
