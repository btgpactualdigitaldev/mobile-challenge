//
//  CurrencyConverterInteractor.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

protocol CurrencyConverterBusinessLogic {
    func fetchGetCurrencies(request: CurrencyConverter.Fetch.Request)
}

final class CurrencyConverterInteractor: CurrencyConverterBusinessLogic {
    
    // MARK:  Properties
    
    var presenter: CurrencyConverterPresentationLogic?
    private var worker: CurrencyConverterWorker?
    
    // MARK: Initializers
    
    init (worker: CurrencyConverterWorker = CurrencyConverterWorker()) {
        self.worker = worker
    }
    
    // MARK: Class Funcitons
    
    func fetchGetCurrencies(request: CurrencyConverter.Fetch.Request) {
        worker?.fetchGetCurrencies(source: request.source, { (data) in
            switch data {
            case .success(let result):
                let response = CurrencyConverter.Fetch.Response(quotes: CurrencyConverterModel(quotes: result.quotes))
                self.presenter?.renderConvertion(response: response)
            case .failure(let error):
                if error == .rede {
                    self.presenter?.showEmptyState()
                } else {
                    self.presenter?.showError(withMessage: error.reason)
                }
            }
        })
    }
    
}
