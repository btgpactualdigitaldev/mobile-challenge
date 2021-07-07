//
//  ConverterViewModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

class ConverterViewModel {
    
    var source: CurrencyModel?
    var destiny: CurrencyModel?
    var dollar: CurrencyModel?
    
    init() { }
    
    func inputValidator(_ value: String?) throws -> Double {
        guard var value = value else { throw ValidationError.inputIsNil }
        guard value.count > 0 else { throw ValidationError.inputIsEmpty }
        
        if value.contains(",") {
            value = value.replacingOccurrences(of: ",", with: ".")
        }
        
        guard let double = Double(value) else { throw ValidationError.inputIsNotDouble }
        guard double > 0 else { throw ValidationError.valueIsNegative }
        
        return double
    }
    
    func currenciesValidation() throws {
        guard let _ = source else { throw ValidationError.unselectedSourceCurrency }
        guard let _ = destiny else { throw ValidationError.unselectedDestinyCurrency }
    }
    
    func performConversion(_ value: Double) -> Double {
        guard
            let source = source,
            let destiny = destiny,
            let sourceDollar = source.valueDollar,
            let destinyDollar = destiny.valueDollar
        else { return 0 }
        
        let USD = Identifier.Currency.USD.rawValue
        var returnValue: Double = 0
        
        if source.code == USD {
            returnValue = value * destinyDollar
        }
        else {
            returnValue = (value / sourceDollar) * destinyDollar
        }
        
        return returnValue
    }
}
