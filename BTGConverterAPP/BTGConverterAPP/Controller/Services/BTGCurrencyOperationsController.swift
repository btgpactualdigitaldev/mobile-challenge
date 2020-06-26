//
//  BTGCurrencyOperationsController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

enum OperationType {
    case toBaseType
    case fromBaseType
    case noBaseTypeConversion
}

struct BTGCurrencyOperationsController {
    
    static func currencyToBaseCurrencyFormatted(inputBaseDecimal: Decimal,to quotesToUsd: Double) -> String {
        return formatNumberToCurrencyConverterVC(BTGCurrencyOperationsController.currencyToBaseCurrencyUnformatted(inputBaseDecimal: inputBaseDecimal, to: quotesToUsd))
    }
    
    static func currencyToBaseCurrencyUnformatted(inputBaseDecimal: Decimal,to quotesToUsd: Double) -> Decimal {
        let quotesDecimal : Decimal = NSNumber(floatLiteral: quotesToUsd).decimalValue
        return inputBaseDecimal/quotesDecimal
    }
    
    static private func formatNumberToCurrencyConverterVC(_ number: Decimal) -> String {
        var components = number.description.components(separatedBy: ".")
        var formatedString = ""
        
        if components.count > 1 && components[1].count > 1 {
            formatedString =  components[0] + ".\(components[1].removeFirst())\(components[1].removeFirst())"
        } else if components.count > 1 && components[1].count == 1 {
            formatedString = components[0] + ".\(components[1].removeFirst())0"
        } else {
            formatedString = components[0] + ".00"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: Double(formatedString)!))!
    }
    
    static func baseCurrencytoTargetFormatted(baseCurrencyQuantity: Decimal,to baseCurrencyQuoteToTarget: Double) -> String {
        
        let quotesDecimal : Decimal = NSNumber(floatLiteral: baseCurrencyQuoteToTarget).decimalValue
        let resultToUSDDecimal = baseCurrencyQuantity*quotesDecimal
        
        return formatNumberToCurrencyConverterVC(resultToUSDDecimal)
    }
    
    static func getOperationType(baseCurrency: String, targetCurrency: String) -> OperationType {
        let baseType = BTGCurrencyQuotesConstants.baseCurrencyAbbreviation.rawValue
        if baseCurrency != baseType && targetCurrency == baseType {
            return .toBaseType
        } else if baseCurrency == baseType && targetCurrency != baseType {
            return .fromBaseType
        } else {
            return .noBaseTypeConversion
        }
    }
    
}
