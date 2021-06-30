//
//  CurrencyListInteractor.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

protocol CurrencyListBusinessLogic {
    func fetchListCurrencies()
}

final class CurrencyListInteractor: CurrencyListBusinessLogic {
    
    // MARK:  Properties
    
    var presenter: CurrencyListPresentationLogic?
    private var worker: CurrencyListWorker?
    
    // MARK: Initializers
    
    init (worker: CurrencyListWorker = CurrencyListWorker()) {
        self.worker = worker
    }
    
    // MARK: Class Funcitons
    
    func fetchListCurrencies() {
        worker?.fetchListCurrencies({ (data) in
            switch data {
            case .success(let result):
                let response = CurrencyList.Fetch.Response(currencies: CurrenciesListModel(currencies: result.currencies))
                self.presenter?.renderCurrenciesList(response: response)
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
