//
//  CurrencyViewModel.swift
//  Curriencies
//
//  Created by Ferraz on 02/09/21.
//

import UIKit

protocol CurrencyViewModeling {
    func getCurrencies(success: @escaping (Bool, String) -> Void)
    func goToCurrencyList(currencyType: CurrencyType,
                          delegate: ChangeCurrencyDelegate) -> UIViewController
    func getValue(originValue: Double) -> String
    func updateCurrency(code: String, type: CurrencyType) -> String 
}

final class CurrencyViewModel {
    private let getCurrenciesUseCase: GetCurrencyUseCaseProtocol
    private let calculateUseCase: CalculateCurrencyUseCaseProtocol
    private var currencies: [CurrencyEntity] = []
    private(set) var originCode: String = "USD"
    private(set) var destinationCode: String = "BRL"
    
    init(getCurrenciesUseCase: GetCurrencyUseCaseProtocol,
         calculateCurrencyUseCase: CalculateCurrencyUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.calculateUseCase = calculateCurrencyUseCase
    }
}

extension CurrencyViewModel: CurrencyViewModeling {
    func getCurrencies(success: @escaping (Bool, String) -> Void) {
        getCurrenciesUseCase.getCurrencies { result in
            switch result {
            case let .success(entities):
                self.currencies = entities
                let value = self.getValue(originValue: 1)
                success(true, value)
            case .failure(_):
                success(false, "1.00")
            }
        }
    }
    
    func getValue(originValue: Double) -> String {
        let value = calculateUseCase.calculateCurrency(currencies: currencies,
                                                       originCode: originCode,
                                                       destinationCode: destinationCode,
                                                       originValue: originValue)
        
        return String(format: "%.2f", value)
    }
    
    func goToCurrencyList(currencyType: CurrencyType,
                          delegate: ChangeCurrencyDelegate) -> UIViewController {
        return CurrencyListFactory.make(currencies: currencies,
                                        currencyType: currencyType,
                                        delegate: delegate)
    }
    
    func updateCurrency(code: String, type: CurrencyType) -> String {
        if type == .destination {
            destinationCode = code
        } else {
            originCode = code
        }
        return getValue(originValue: 1)
    }
}
