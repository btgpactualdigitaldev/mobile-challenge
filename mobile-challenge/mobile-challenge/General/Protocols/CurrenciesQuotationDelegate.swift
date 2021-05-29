//
//  File.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import Foundation

protocol CurrenciesQuotationDelegate: class {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation], tagButton: TagButton)
    func didFinishFetchQuotationsWithError(error: CurrencyError, tagButton: TagButton)
}

protocol SelectCurrencyQuotationDelegate: class {
    var childCoordinators: [Coordinator] { get set }
    
    func didSelectCurrrencyQuotation(as tagButton: TagButton, currencyQuotation: CurrencyQuotation)
}
