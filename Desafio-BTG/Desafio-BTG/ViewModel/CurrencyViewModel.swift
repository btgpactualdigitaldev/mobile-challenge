//
//  CurrencyViewModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import Foundation

protocol DataDelegete {
    func gettingCountryOne(countryOne: String)
    func gettingCountryTwo(countryTwo: String)
}

final class CurrencyViewModel: DataDelegete {
    
    var countrySelectedOne: String?
    var countrySelectedTwo: String?
    var filterData: [String:String] = [:]
    
    var setSearchBar: [(key: String, value: String)] {
        get {
            return Array(filterData)
        }
    }
    
    func gettingCountryOne(countryOne: String) {
        self.countrySelectedOne = countryOne
    }
    
    func gettingCountryTwo(countryTwo: String) {
        self.countrySelectedTwo = countryTwo
    }
    
    private let apiCurrentValue: RealTimeRatesApiProtocol
    private let api: CurrencyListModelProtocol
    private var modelValue: RealTimeRatesModel?
    public var modelValueList = [String:String]()
    
    init(api: CurrencyListModelProtocol = RequestApi(), apiCurrentValue: RealTimeRatesApiProtocol = RequestApi()) {
        self.api = api
        self.apiCurrentValue = apiCurrentValue
    }
    
    /// Function responsible for bringing the current value of the currency
    func fetchDetails(_ completion: @escaping (Bool) -> Void) {
        api.fetchCurrencyList { statusCode, model in
            guard let statusCode = statusCode else { return }
            if ConnectionErrorManager.isSuccessfulStatusCode(statusCode: statusCode) {
                guard let model = model else { return }
                self.modelValueList = model.currencies
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    var setContentCurrencies: [(key: String, value: String)] {
        get {
            var dict = Array(modelValueList)
            dict.sort(by: ({$0 < $1}))
            return dict
        }
    }
    
    /// Function responsible for searching the name of the countries and their acronym
    func fetchCurrentValue(_ completion: @escaping (Bool) -> Void) {
        apiCurrentValue.fetchRealTimeRates { statusCode, model in
            guard let statusCode = statusCode else { return }
            if ConnectionErrorManager.isSuccessfulStatusCode(statusCode: statusCode) {
                guard let model = model else { return }
                self.modelValue = model
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    /// function responsible for carrying out all currency conversion logic
    /// - Parameters:
    ///   - ofCurrency: country of origin
    ///   - toCurrency: destiny country
    ///   - value: value to be converted
    ///   - completionHendler: final conversion result to display on the screen
    func loadCurrencyData(ofCurrency: String, toCurrency: String, value: Double, completionHendler: @escaping (Double?) -> Void) {
        var finalResult = 0.0
        
        modelValue?.quotes.forEach {
            if "USD\(ofCurrency)" == $0.key {
                finalResult = value / $0.value
            }
        }
        modelValue?.quotes.forEach {
            if "USD\(toCurrency)" == $0.key {
                finalResult = finalResult * $0.value
            }
        }
        completionHendler(finalResult)
    }
}
