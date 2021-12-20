//
//  CurrencyListViewModel.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

class CurrencyListViewModel {
    var selectedButton: SelectedButton
    var selectedCurrency: Currency?
    var currencies: [Currency] = []
    var filteredCurrencies: [Currency] = []
    
    func selectCurrency(_ currency: Currency) {
        self.selectedCurrency = currency
    }
    
    init(selectedButton: SelectedButton) {
        self.selectedButton = selectedButton
    }
    
    func getCurrencies(callback: @escaping (ApiError?) -> Void) {
        
        if let currencies = CoreDataManager.shared.fetchAllCurrencies() {
            self.currencies = currencies
            self.filteredCurrencies = currencies
            callback(nil)
        } else {
            CurrencyService<CurrencyList>.list.http({ [weak self] response in
                guard let wSelf = self else { return }
                switch response {
                case .success(let curr):
                    wSelf.currencies = curr.currencies!
                    wSelf.filteredCurrencies = curr.currencies!
                    callback(nil)
                case .failure(let err):
                    callback(err)
                }
            })
        }
    }
}
