//
//  CurrencyListViewModel.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import Foundation
import Network

class CurrencyListViewModel {

    enum FilterType: Int {
        case name
        case code
    }

    @LocalStorage(key: .currencies) var localCurrencies: [Currency]?

    private let monitor = NWPathMonitor()
    private var isConnected = false {
        didSet {
            getCurrencyList()
        }
    }

    var onUpdate: () -> Void = { }

    private var service: CurrencyListProviding

    private var currencies = [Currency]()
    private var showingCurrencies = [Currency]() {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }

    init(service: CurrencyListProviding) {
        self.service = service

        getCurrencyList()

        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
        let queue = DispatchQueue(label: .init())
        monitor.start(queue: queue)
    }

    /// Get the currency list from API
    private func getCurrencyList() {
        if isConnected {
            service.getCurrencyList { [weak self] result in
                switch result {
                case .success(let currencyList):
                    guard let self = self else { return }

                    self.currencies = currencyList.currencies.sorted { $0.name < $1.name }
                    self.showingCurrencies = self.currencies

                    self.localCurrencies = self.showingCurrencies

                case .failure(let error):
                    print(error)
                }
            }

        } else {
            currencies = localCurrencies ?? []
            showingCurrencies = currencies
        }
    }

    /// Sort currencies by currency name or currency code
    /// - Parameter segmentIndex: index used to schoose sorting type
    func sort(by segmentIndex: Int) {
        let filterType = FilterType(rawValue: segmentIndex)

        switch filterType {
        case .name:
            showingCurrencies.sort { $0.name < $1.name }
        case .code:
            showingCurrencies.sort { $0.code < $1.code }
        default:
            return
        }
    }

    /// Returns a currency for an specific index
    /// - Parameter index: index to be found
    /// - Returns: currency found
    func getCurrency(for index: Int) -> Currency {
        return showingCurrencies[index]
    }

    /// Returns currencies array size
    /// - Returns: currencies array size
    func getCurrenciesSize() -> Int {
        return showingCurrencies.count
    }

    /// Filter currencies by given text
    /// - Parameter text: text used to filter currencies
    func filter(by text: String) {
        guard let localCurrencies = localCurrencies else { return }

        if text.isEmpty {
            showingCurrencies = localCurrencies
        } else {
            showingCurrencies = localCurrencies.filter {
                $0.name.lowercased().contains(text.lowercased())
                    || $0.code.lowercased().contains(text.lowercased())
            }
        }
    }
}
