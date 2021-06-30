//
//  CurrencyListPresenter.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

protocol CurrencyListPresentationLogic {
    func showEmptyState()
    func showError(withMessage message: String)
    func renderCurrenciesList(response: CurrencyList.Fetch.Response)
}

final class CurrencyListPresenter: CurrencyListPresentationLogic {
    
    weak var viewController: (CurrencyListViewController)?
    
    func showError(withMessage message: String) {
        viewController?.showErrorAlert(with: message)
    }
    
    func showEmptyState() {
        viewController?.showEmptyState()
    }
    
    func renderCurrenciesList(response: CurrencyList.Fetch.Response) {
        let viewModel = CurrencyList.Fetch.ViewModel(currencies: response.currencies)
        viewController?.renderCurrenciesList(viewModel: viewModel)
    }
    
}
