//
//  CurrencyConverterViewModel.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 29/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewModelDelegate: class {
    func updateValue()
    func updateView()
    func swapValues()
}

class CurrencyConverterViewModel {
    var currencyList: [Currency]? = []
    private var currentQuote: CurrentQuote? = nil
    private var selectedFromCurrency: Currency? = nil
    private var selectedToCurrency: Currency? = nil
    private var convertedValue: Double? = nil
    var hasError: Bool
    private var selectedButon: ConvertType = .from
    weak var delegate: CurrencyConverterViewModelDelegate?
    let service: ServiceManager?
    init(hasError: Bool, service: ServiceManager = ServiceManager.sharedInstance) {
        self.hasError = hasError
        self.service = service
    }
}

extension CurrencyConverterViewModel {
    private var defaultCurrencyTitle: String { return "USD" }
    var vcIdentifier: String { return "currencyModal" }
    private var defaultuCurrency: Currency? {
        guard let currentQuote = currentQuote,
        let currencyList = currencyList,
        let source = currentQuote.source  else { return nil }
        return currencyList.first(where: { $0.currency == source })
    }

    private func setDefaultSelectedButton() {
        guard let defaultuCurrency = defaultuCurrency,
            let currencyList = currencyList,
            currencyList.isEmpty == false else { return }
        selectedFromCurrency = defaultuCurrency
        selectedToCurrency = currencyList.first
    }

    var fromCurrencyTitle: String? { return selectedFromCurrency?.currency }
    var toCurrencyTitle: String? { return selectedToCurrency?.currency }
    var convertedCurrancy: String? {
        return convertedValue?.currency
    }
    
    var alertTitle: String { return "Não foi possivel completar a operação" }
    var alertMessage: String {
        var message = "Por Favor, tente novamente mais tarde"
        if let value = DataManager.instance.getQuotes(), !value.isEmpty {
            message = "\(message). Enquanto isso, aproveite o aplicativo com as informações armazenadas da ultima sessão"
        }
        return message
    }

    func convertCurrency(value: String?) {
        guard let inputValue = value?.replacingOccurrences(of: ",", with: "").doubleValue,
            let toValue = selectedToCurrency?.value,
            let fromValue = selectedFromCurrency?.value else { return }
        if (selectedFromCurrency?.currency == defaultCurrencyTitle) {
            convertedValue = inputValue * toValue
        } else {
            convertedValue = (inputValue/fromValue) * toValue
        }
        delegate?.updateValue()
        
    }
    
    func setSelectedButton(selected: ConvertType) {
        selectedButon = selected
    }
    
    func setNewCurrency(currency: Currency) {
        if selectedButon == .from { selectedFromCurrency = currency }
        else { selectedToCurrency = currency }
    }
    
    func swapCurrency() {
        swap(&selectedFromCurrency, &selectedToCurrency)
        delegate?.swapValues()
    }
}

// MARK: Fetch function

extension CurrencyConverterViewModel {
    func searchForCurrentQuote() {
        service?.currentQuoteRequest { [weak self] (currentQuote, err) in
            if let _ = err { self?.hasError = true }
            let values = (currentQuote != nil && currentQuote?.quotes != nil) ? currentQuote?.quotes : DataManager.instance.getQuotes()
            if let values = values {
                DataManager.instance.setQuotes(quotes: values)
                for (key, value) in Array(values).sorted(by: { $0.0 < $1.0 }) {
                    self?.currencyList?.append(Currency(value: value, currency: String(key.dropFirst(3))))
                }
                self?.currentQuote = currentQuote
            }
            self?.setDefaultSelectedButton()
            self?.delegate?.updateView()
        }
    }
}
