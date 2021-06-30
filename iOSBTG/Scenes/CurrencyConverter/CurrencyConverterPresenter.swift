//
//  CurrencyConverterPresenter.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

protocol CurrencyConverterPresentationLogic {
    func renderConvertion(response: CurrencyConverter.Fetch.Response)
    func showError(withMessage message: String)
    func showEmptyState()
}

final class CurrencyConverterPresenter: CurrencyConverterPresentationLogic {
    
    weak var viewController: (CurrencyConverterViewController)?
    
    func showError(withMessage message: String) {
        viewController?.showErrorAlert(with: message)
    }
    
    func showEmptyState() {
        viewController?.showEmptyState()
    }
    
    func renderConvertion(response: CurrencyConverter.Fetch.Response) {
        let viewModel = CurrencyConverter.Fetch.ViewModel(quotes: response.quotes)
        viewController?.renderConvertion(viewModel: viewModel)
    }
}
