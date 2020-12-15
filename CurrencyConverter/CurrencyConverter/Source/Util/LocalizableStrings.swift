//
//  LocalizableStrings.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

enum LocalizableStrings: String {
    
    case generalLoadingText
    case generalCancelText
    case generalEqualSign
    
    case currencyConverterViewTitle
    case currencyConverterViewValuePlaceholder
    case currencyConverterViewLastUpdatedTaxes
    case currencyConverterViewTapToSelect
    
}

extension LocalizableStrings {
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    func localizedWith(_ values: CVarArg...) -> String {
        return String(format: self.localized, arguments: values)
    }

}
