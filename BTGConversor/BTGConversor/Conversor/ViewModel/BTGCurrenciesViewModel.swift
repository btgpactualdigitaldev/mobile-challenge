//
//  BTGCurrenciesViewModel.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/15/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

protocol BTGCurrenciesViewDelegate: AnyObject {
    func load(_ viewModel: BTGCurrenciesViewModel)
    func showError(_ viewModel: BTGCurrenciesViewModel, error: BTGError)
}

final class BTGCurrenciesViewModel {
    
    let service: ConversorService
    var currencies: [(String, String)] = [] {
        didSet {
            currenciesToDisplay = currencies.sorted(by: { (currency1, currency2) -> Bool in
                return currency1.0 < currency2.0
            })
        }
    }
    var currenciesToDisplay: [(String, String)] = []
    
    weak var viewDelegate: BTGCurrenciesViewDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    var didSelectCurrency: (((String, String)) -> Void)?
    
    init(_ service: ConversorService) {
        self.service = service
    }
    
    func numberOfRows() -> Int {
        return currenciesToDisplay.count
    }
    
    func getCurrency(for indexPath: IndexPath) -> (String, String) {
        return currenciesToDisplay[indexPath.row]
    }
    
    func fetchCurrencies() {
        service.fetchCurrencies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                var newCurrencies: [(String, String)] = []
                data.currencies.forEach { (currency) in
                    newCurrencies.append((currency.key, currency.value))
                }
                self.currencies = newCurrencies
                self.viewDelegate?.load(self)
            case .failure(let error):
                self.viewDelegate?.showError(self, error: error)
            }
        }
    }
    
    func didTapCurrency(at indexPath: IndexPath) {
        let currency = currenciesToDisplay[indexPath.row]
        didSelectCurrency?(currency)
    }
    
    func popViewController() {
        coordinatorDelegate?.popViewController()
    }
    
}
