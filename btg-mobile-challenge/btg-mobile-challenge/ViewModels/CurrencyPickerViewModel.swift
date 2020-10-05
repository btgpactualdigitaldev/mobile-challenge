//
//  CurrencyPickerViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation
import os.log

/// The protocol responsible for establishing a communication path
/// between `CurrencyPickerViewModel` and `CurrencyPickerViewController`.
protocol CurrencyPickerViewModelDelegate: AnyObject {
    /// Informs the delegate to update its selected currency.
    func didSelectCurrency(_ new: IndexPath, previous: IndexPath)
}

/// The `ViewModel` responsible for `CurrencyPickerViewController`.
final class CurrencyPickerViewModel {
    //- MARK: Properties
    /// The delegate responsible for `ViewModel -> View` binding.
    weak var delegate: CurrencyPickerViewModelDelegate?

    @UserDefaultAccess(key: CurrencyPickingCase.from.rawValue, defaultValue: "USD")
    private var fromCurrencyStorage: String

    @UserDefaultAccess(key: CurrencyPickingCase.to.rawValue, defaultValue: "BRL")
    private var toCurrencyStorage: String

    /// The `Coordinator` associated with this `ViewModel`.
    private let coordinator: CurrencyConverterCoordinatorService

    /// The currency case of this `ViewModel`.
    private let `case`: CurrencyPickingCase

    /// The list of supported currencies.
    private var currencies: [[Currency]] = [[Currency]]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.currentCurrency = self.lastSelectedCurrency
            }
        }
    }

    /// The last selected currency.
    private var lastSelectedCurrency: IndexPath

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter listResponse: The list of supported currencies.
    /// - Parameter coordinator: The `Coordinator` associated with this `ViewModel`.
    /// - Parameter case: The currency case of this `ViewModel`.
    init(currencies: ListCurrencyResponse,
         coordinator: CurrencyConverterCoordinatorService,
         case: CurrencyPickingCase) {
        self.coordinator = coordinator
        self.case = `case`
        self.currentCurrency = IndexPath(row: 0, section: 0)
        self.lastSelectedCurrency = IndexPath(row: 0, section: 0)
        switch `case` {
        case .from:
            self.title = "From"
        case .to:
            self.title = "To"
        }
        convert(from: currencies)
        os_log("CurrencyPickerViewModel initialized.", log: .appflow, type: .debug)
    }

    //- MARK: API
    /// The title of the `View`.
    let title: String

    /// The currently selected currency.
    var currentCurrency: IndexPath {
        didSet {
            switch `case` {
            case .from:
                fromCurrencyStorage = currencies[currentCurrency.section][currentCurrency.row].code
            case .to:
                toCurrencyStorage = currencies[currentCurrency.section][currentCurrency.row].code
            }
            delegate?.didSelectCurrency(currentCurrency, previous: oldValue)
        }
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

    //- MARK: Private
    /// Converts a `ListCurrencyResponse` into `[[Currency]]`, sorted in alphabetical order
    /// of a currency's code.
    private func convert(from response: ListCurrencyResponse) {
        let currencies = response.currencies.keys.map { Currency(code: $0, name: response.currencies[$0] ?? "") }
        let sortedCurrencies = currencies.sorted(by: { $0.code < $1.code })

        var currentCurrencyIndex: Int = 0
        switch self.`case` {
        case .from:
            if let lastSelectedIndex = sortedCurrencies.firstIndex(where: { $0.code == self.fromCurrencyStorage }) {
                currentCurrencyIndex = lastSelectedIndex
            }
        case .to:
            if let lastSelectedIndex = sortedCurrencies.firstIndex(where: { $0.code == self.toCurrencyStorage }) {
                currentCurrencyIndex = lastSelectedIndex
            }
        }

        let result = [sortedCurrencies]

        lastSelectedCurrency = IndexPath(row: currentCurrencyIndex, section: result.count - 1)

        self.currencies = result
    }
}
