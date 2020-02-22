//
//  CurrencyConverterViewModel.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewModelDelegate: class {
    func successConvertCurrency(result: Double)
    func failureConvertCurrency(error: String)
}

class CurrencyConverterViewModel {
    
    private var dataSource: CurrencyConverterDataSourceProtocol?
    weak var delegate: CurrencyConverterViewModelDelegate?
    
    init(dataSource: CurrencyConverterDataSourceProtocol) {
        self.dataSource = dataSource
        self.dataSource?.delegate = self
    }
    
    func convertCurrency(from: String, to: String, amount: Double) {
        dataSource?.convertCurrency(from: from, to: to, amount: amount)
    }
    
    func getCurrencyList(completion: @escaping (_ list: [Currency]?, _ error: String?) -> Void) {
        dataSource?.getCurrencyList(completion: completion)
    }
}

extension CurrencyConverterViewModel: CurrencyConverterDataSourceDelegate {
    func successConvertCurrency(result: Double) {
        delegate?.successConvertCurrency(result: result)
    }
    
    func failureConvertCurrency(error: String) {
        delegate?.failureConvertCurrency(error: error)
    }
}
