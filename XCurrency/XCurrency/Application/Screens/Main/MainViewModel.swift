//
//  MainViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import Foundation

class MainViewModel: GenericModel {

    // MARK: - Attributes
    private var repository: CurrencyRepositoryProtocol
    private var currenciesRate: [CurrencyRate] = []
    private let formatter: NumberFormatter
    var errorMessage: String = ""
    var updateErrorMessage: () -> Void = {}
    var updateCurrencies: () -> Void = {}
    var convertedValue: String = "0.0"
    var firstCurrency: Currency? {
        didSet {
            self.updateCurrencies()
        }
    }
    var secondCurrency: Currency? {
        didSet {
            self.updateCurrencies()
        }
    }

    // MARK: - Initializer
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.repository = currencyRepository
        self.formatter = NumberFormatter()
        super.init()
        self.setupFormatter()
        self.getCurrenciesRate()
    }

    // MARK: - Private Methods
    private func getCurrenciesRate() {
        self.repository.getCurrenciesRate { [weak self] result in
            switch result {
            case .success(let currencyRateObject):
                self?.currenciesRate = currencyRateObject.currenciesRate
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                DispatchQueue.main.async {
                    self?.updateErrorMessage()
                }
            }
        }
    }

    private func setupFormatter() {
        self.formatter.numberStyle = .currency
        self.formatter.minimumFractionDigits = 2
        self.formatter.currencySymbol = ""
    }

    private func convertCurrencyToCurrency(firstCurrencyCode: String, secondCurrencyCode: String, valueToConvert: Double) {
        if let firstTax = self.currenciesRate.first(where: { $0.source == firstCurrencyCode }), let secondTax = self.currenciesRate.first(where: { $0.source == secondCurrencyCode }){
            let value = (valueToConvert/firstTax.value) * secondTax.value
            if let formattedText = self.formatter.string(from: NSNumber(value: value)) {
                self.convertedValue = formattedText
                self.updateCurrencies()
            }
        }
    }

    // MARK: - Public Methods
    func presentCurrencySelector(order: CurrenciesPosition) {
        if let router = self.router as? MainRouter {
            router.presentCurrencysView(order: order, selectedCurrency: { currency in
                switch order {
                case .first:
                    self.firstCurrency = currency
                case .second:
                    self.secondCurrency = currency
                }
            })
        }
    }

    func convertValueToCurrency(valueToConvert: Double) {
        if let firstCurrency = self.firstCurrency, let secondCurrency = self.secondCurrency {
            let firstCode: String = "USD\(firstCurrency.code)"
            let secondCode: String = "USD\(secondCurrency.code)"
            self.convertCurrencyToCurrency(firstCurrencyCode: firstCode, secondCurrencyCode: secondCode, valueToConvert: valueToConvert)
        }
    }
}
