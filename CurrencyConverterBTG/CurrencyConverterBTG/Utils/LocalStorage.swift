//
//  LocalStorage.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 25/03/21.
//

import Foundation

final class LocalStorage {

    static private let currenciesNamesString = "CurrenciesNames"
    static private let currenciesCodesString = "CurrenciesCodes"
    static private let conversionsCodesString = "ConversionsCodes"
    static private let conversionsValuesString = "ConversionsValues"
    
    static func store(currencies: [Currency]) {
        let names = currencies.map { $0.name }
        let codes = currencies.map { $0.code }
        UserDefaults.standard.set(names, forKey: LocalStorage.currenciesNamesString)
        UserDefaults.standard.set(codes, forKey: LocalStorage.currenciesCodesString)
    }
    
    static func store(conversions: [Conversion]) {
        let codes = conversions.map { $0.code }
        let values = conversions.map { $0.value }
        UserDefaults.standard.set(codes, forKey: LocalStorage.conversionsCodesString)
        UserDefaults.standard.set(values, forKey: LocalStorage.conversionsValuesString)
    }
    
    static func retrieveCurrencies() -> [Currency]? {
        guard let currenciesNames = UserDefaults.standard.array(forKey: LocalStorage.currenciesNamesString) as? [String],
              let currenciesCodes = UserDefaults.standard.array(forKey: LocalStorage.currenciesCodesString) as? [String] else {
            return nil
        }
        var currencies = [Currency]()
        currenciesNames.enumerated().forEach { (i, name) in
            currencies.append(Currency(code: currenciesCodes[i], name: name))
        }
        return currencies
    }
    
    static func retrieveConversions() -> [Conversion]? {
        guard let conversionsCodes = UserDefaults.standard.array(forKey: LocalStorage.conversionsCodesString) as? [String],
              let conversionsValues = UserDefaults.standard.array(forKey: LocalStorage.conversionsValuesString) as? [Double] else {
            return nil
        }
        var conversions = [Conversion]()
        conversionsCodes.enumerated().forEach { (i, code) in
            conversions.append(Conversion(code: code, value: conversionsValues[i]))
        }
        return conversions
    }
}
