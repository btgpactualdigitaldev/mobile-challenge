//
//  CurrencyViewModel.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import UIKit

class CurrencyViewModel {
    var firstCurrency: Currency?
    var secondCurrency: Currency?
    var delegate: CurrencyViewModelDelegate?
    var searchActive = false
    
    private var currencyList: CurrencyList?
    private var filtered = [Currency]()
    private var selectedValue: Double?
    
    private let retrieveRemoteCurrencies = RetrieveRemoteCurrenciesUseCase()
    private let convert = ConvertValueUseCase()
    
    func getCurrencies()  {
        self.delegate?.showLoading()
        DispatchQueue.global().async {
            self.retrieveRemoteCurrencies.execute { (response) in
                DispatchQueue.main.async {
                    self.delegate?.hideLoading()
                    if let currencies = response {
                        self.currencyList = currencies
                        self.delegate?.updateViewState(success: true)
                    } else {
                        self.delegate?.genericError()
                        self.delegate?.updateViewState(success: false)
                    }
                }
            }
        }
    }
    
    func selectFirst(currency: Currency) {
        if currency.symbol == self.secondCurrency?.symbol {
            self.firstCurrency = nil
        }
        self.firstCurrency = currency
        if let value = self.selectedValue {
            self.convertValueFrom(text: String(value))
        }
        self.delegate?.updateViewState(success: true)
    }
    
    func selectSecond(currency: Currency) {
        if currency.symbol == self.firstCurrency?.symbol {
            self.firstCurrency = nil
        }
        self.secondCurrency = currency
        if let value = self.selectedValue {
            self.convertValueFrom(text: String(value))
        }
        self.delegate?.updateViewState(success: true)
    }
    
    func convertValueFrom(text: String?) {
        guard let text = text, let value = Double(text) else { return }
        self.selectedValue = value
        guard let from = self.firstCurrency, let to = self.secondCurrency, let source = self.currencyList?.source else { return }
        let converted = self.convert.execute(value: value, from: from, to: to, source: source)
        self.delegate?.showConverted(value: String(converted))
    }
    
    func numberOfCurrencies() -> Int? {
        return self.searchActive ? self.filtered.count :  self.currencyList?.currencies.count
    }
    
    func currencyFor(row: Int) -> Currency? {
        return self.searchActive ? self.filtered[row] : self.currencyList?.currencies[row]
    }
    
    func filterCurrencyby(text: String) {
        guard let currencies = self.currencyList?.currencies else { return }
        self.filtered = text.isEmpty ? currencies : currencies.filter({
            $0.name.localizedCaseInsensitiveContains(text) || $0.symbol.localizedCaseInsensitiveContains(text)
        })
    }
}
