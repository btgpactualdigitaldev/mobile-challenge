//
//  Locale+CurrencyCode.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import Foundation

extension Locale {
    static func getLocale(byCurrencyCode code: String) -> Locale? {
       let locales: [String] = Locale.availableIdentifiers
       for locadeId in locales {
           let locale = Locale(identifier: locadeId)
           if locale.currencyCode == code {
               return locale
           }
       }
       return nil
   }
}
