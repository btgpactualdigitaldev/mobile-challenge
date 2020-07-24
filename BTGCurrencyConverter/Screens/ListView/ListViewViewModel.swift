//
//  ListViewViewModel.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

class ListViewViewModel {
    static let shared = ListViewViewModel()
    var currencies: Currencies? {
        didSet {
            if let currencies = currencies {
                PersistenceController.updateCurrencies(currencies)
            }
        }
    }
    
    private init() {
        PersistenceController.retreiveCurrencies { [weak self] currencies in
            self?.currencies = currencies
        }
    }
    
    func getCurrencies(completed: @escaping(Result<[Currency], BTGNetworkError>)->Void) {
        if currencies?.isValid ?? false {
            completed(.success(currencies!.list))
        } else {
            NetworkController.shared.getCurrencies { [weak self] result in
                switch result {
                case .success(let supportedCurrencies):
                    let currencies = Currencies(supportedCurrencies: supportedCurrencies)
                    self?.currencies = currencies
                    completed(.success(currencies.list))
                case .failure(let error):
                    if let currencies = self?.currencies {
                        completed(.success(currencies.list))
                    } else {
                        completed(.failure(error))
                    }
                }
            }
        }
    }
}

