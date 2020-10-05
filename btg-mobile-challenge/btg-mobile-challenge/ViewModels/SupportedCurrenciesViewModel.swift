//
//  SupportedCurrenciesViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation
import os.log

/// The `VieModel` responsible for `SupportedCurrenciesViewController`.
final class SupportedCurrenciesViewModel {
    //- MARK: Properties
    /// The list of supported currencies.
    private var currencies: [[Currency]] = [[Currency]]()

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter currencies: The list of supported currencies in response form.
    init(currencies: ListCurrencyResponse) {
        self.currencies = convert(from: currencies)
        os_log("SupportedCurrenciesViewModel initialized.", log: .appflow, type: .debug)
    }

    /// The number of sections to be displayed in the `View`.
    var numberOfSections: Int {
        return currencies.count
    }

    /// Returns the number of rows to be displayed in a given section.
    /// - Parameter section: The section in the `View`.
    func numberOfRows(in section: Int) -> Int {
        return currencies[section].count
    }

    /// Returns a currency's code at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func currencyCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].code
    }

    /// Returns a currency's name at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func currencyNameAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].name
    }

    /// Converts a `ListCurrencyResponse` into `[[Currency]]`, sorted in alphabetical order
    /// a currency's code.
    private func convert(from response: ListCurrencyResponse) -> [[Currency]] {
        let currencies = response.currencies.keys.map { Currency(code: $0, name: response.currencies[$0] ?? "") }
        let sortedCurrencies = currencies.sorted(by: { $0.code < $1.code })

        let result = [sortedCurrencies]

        return result
    }
}
