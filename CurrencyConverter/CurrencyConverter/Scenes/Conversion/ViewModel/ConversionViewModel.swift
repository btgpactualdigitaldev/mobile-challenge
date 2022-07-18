//
//  ConversionViewModel.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 15/07/22.
//

import Foundation

protocol ConversionViewModelDelegate: AnyObject {
    func convertedValueDidChange(value: Float)
    func initialCurrencyDidChange(currency: String)
    func finalCurrencyDidChange(currency: String)
}

protocol ConversionViewModelProtocol: AnyObject {
    var conversionViewModelDelegate: ConversionViewModelDelegate? { get set }
    func fetchQuotationLive()
    func onInitialCurrencyChange(currency: String)
    func onFinalCurrencyChange(currency: String)
    func onValueChange(value: Float)
}

class ConversionViewModel: ConversionViewModelProtocol {
    
    // MARK: - Dependencies
    
    weak var conversionViewModelDelegate: ConversionViewModelDelegate?
    private var service: ConversionServiceProtocol
    
    init(service: ConversionServiceProtocol = ConversionServiceDefault()) {
        self.service = service
    }

    // MARK: - Properties
    
    private var quotationLiveResponse: QuotationLive?
    
    private var convertedValue: Float? {
        didSet {
            conversionViewModelDelegate?.convertedValueDidChange(value: convertedValue ?? 0)
        }
    }

    private var input: Float? {
        didSet {
            updateConvertedValue()
        }
    }
    
    private var initialCurrency: String? {
        didSet {
            conversionViewModelDelegate?.initialCurrencyDidChange(currency: formatCurrencyName(currency: initialCurrency ?? ""))
            updateConvertedValue()
        }
    }
    
    private var finalCurrency: String? {
        didSet {
            conversionViewModelDelegate?.finalCurrencyDidChange(currency: formatCurrencyName(currency: finalCurrency ?? ""))
            updateConvertedValue()
        }
    }
    
    // MARK: - Functions
    
    func fetchQuotationLive() {
        service.fetchQuotationLive { result in
            switch result {
            case .success(let quotationLive):
                self.quotationLiveResponse = quotationLive
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func onInitialCurrencyChange(currency: String) {
        initialCurrency = currency
    }
    
    func onFinalCurrencyChange(currency: String) {
        finalCurrency = currency
    }
    
    func onValueChange(value: Float) {
        input = value
    }
    
    private func updateConvertedValue() {
        convertedValue = convertCurrency()
    }
    
    private func convertCurrency() -> Float {
        guard let initialCurrency = initialCurrency,
              let finalCurrency = finalCurrency,
              let input = input
        else { return 0 }
        let initialCurrencyValue = getCurrencyValue(currency: initialCurrency)
        let dolars = input / initialCurrencyValue
        let finalCurrencyValue = getCurrencyValue(currency: finalCurrency)
        return finalCurrencyValue * dolars
    }
    
    private func getCurrencyValue(currency: String) -> Float {
        guard let currencyValue = quotationLiveResponse?.quotes[currency] else { return 0 }
        return currencyValue
    }
    
    private func formatCurrencyName(currency: String) -> String {
        String(currency.dropFirst(3))
    }
    
}
