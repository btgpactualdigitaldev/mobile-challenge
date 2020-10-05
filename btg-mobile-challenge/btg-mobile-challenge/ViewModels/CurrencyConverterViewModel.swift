//
//  CurrencyConverterViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation
import Network
import os.log

/// The protocol responsible for establishing a communication path
/// between `CurrencyConverterViewModel` and `CurrencyViewController`.
protocol CurrencyConverterViewModelDelegate: AnyObject {
    /// Updates the UI of the View.
    func updateUI()
    func showError(_ error: String)
}

/// The `ViewModel` responsible for `CurrencyConverterViewController`.
final class CurrencyConverterViewModel {
    //- MARK: Properties
    /// The quotes with `USD` as source.
    typealias Quotes = [String: Double]
    
    /// The delegate responsible for `ViewModel -> View` binding.
    weak var delegate: CurrencyConverterViewModelDelegate?

    @UserDefaultAccess(key: CurrencyPickingCase.from.rawValue, defaultValue: "USD")
    private var fromCurrencyStorage: String

    @UserDefaultAccess(key: CurrencyPickingCase.to.rawValue, defaultValue: "BRL")
    private var toCurrencyStorage: String

    /// The manager responsible for network calls.
    private let networkManager: NetworkManager

    /// The monitor responsible for checking connection status.
    private let networkMonitor: NWPathMonitor

    /// The `Coordinator` associated with this `ViewModel`.
    private let coordinator: CurrencyConverterCoordinatorService

    /// The `USD` currency quotes.
    private var quotes: Quotes = [:]

    /// The last `ListCurrencyResponse` request result.
    private var lastListResponse: ListCurrencyResponse?
    
    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter networkManager: The manager responsible for network calls.
    /// - Parameter coordinator: The `Coordinator` associated with this `ViewModel`.
    /// - Parameter networkMonitor: The monitor responsible for checking conneciton status.
    init(networkManager: NetworkManager,
         coordinator: CurrencyConverterCoordinatorService,
         networkMonitor: NWPathMonitor = NWPathMonitor()) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        self.networkMonitor = networkMonitor
        os_log("CurrencyConverterViewModel initialized.", log: .appflow, type: .debug)

        self.networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                os_log("CurrencyConverterViewModel has access to internet connection.", log: .networking, type: .debug)
            } else {
                self.delegate?.showError("No connection. Displaying cached results, if available.")
            }
        }

        self.networkMonitor.start(queue: .main)
    }

    //- MARK: API
    /// The amount to be converted.
    var amount: String = "" {
        didSet {
            convertedAmount = convert(amount)
            delegate?.updateUI()
        }
    }

    /// The currency being converted from.
    var fromCurrency: String {
        return fromCurrencyStorage
    }

    /// The currency being converted to.
    var toCurrency: String {
        return toCurrencyStorage
    }

    /// The converted amount.
    var convertedAmount: String = ""

    /// Warns `Coordinator` to navigate to the currency picker screen.
    /// - Parameter case: The currency case picked by the user.
    func pickCurrency(_ case: CurrencyPickingCase) {
        guard let listResponse = lastListResponse else {
            return
        }

        os_log("CurrencyConverterViewModel asked Coordinator to pick currency.", log: .appflow, type: .debug)

        coordinator.pickCurrency(`case`, currencies: listResponse)
    }

    /// Warns `Coordinator` to navigate to list of currencies screen.
    func listCurrencies() {
        guard let currencies = lastListResponse else {
            return
        }

        os_log("CurrencyConverterViewModel asked Coordinator for list of supported currencies.", log: .appflow, type: .debug)

        coordinator.showCurrencies(currencies)
    }

    // - MARK: Fetch
    /// Fetches data from `NetworkManager` and caches the result.
    func fetch() {
        os_log("CurrencyConverterViewModel requested a fetch for data.", log: .networking, type: .debug)
        fetchLive()
        fetchList()
    }

    //- MARK: Refresh
    /// Refreshes both the data and cache.
    /// Call this function if you want to invalidate the cache or
    /// get the most up to date data from `NetworkManager`.
    func refresh() {
        os_log("CurrencyConverterViewModel requested a refresh of data.", log: .networking, type: .debug)
        fetchList(false)
        fetchLive(false)
    }

    private func fetchLive(_ cache: Bool = true) {
        os_log("CurrencyConverterViewModel fetching /live results...", log: .networking, type: .debug)
        guard let endpoint = Endpoint.live.url else {
            return
        }

        var request: URLRequest?
        if cache {
            request = URLRequest(url: endpoint, cachePolicy: .returnCacheDataElseLoad)
        } else {
            request = URLRequest(url: endpoint, cachePolicy: .reloadIgnoringCacheData)
        }

        guard let urlRequest = request else {
            return
        }

        networkManager.perform(urlRequest, for: LiveCurrencyReponse.self) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let live):
                os_log("CurrencyConverterViewModel fetched /live results.", log: .networking, type: .debug)
                let trimmedQuotes = self.trimmedQuotes(live.quotes)
                self.quotes = trimmedQuotes
            case .failure(let error):
                if error == .decodingFailed {
                    
                }
                os_log("CurrencyConverterViewModel failed to fetch /live results.", log: .networking, type: .debug)
            }
        }
    }

    private func fetchList(_ cache: Bool = true) {
        os_log("CurrencyConverterViewModel fetching /list results...", log: .networking, type: .debug)
        guard let endpoint = Endpoint.list.url else {
            return
        }

        var request: URLRequest?
        if cache {
            request = URLRequest(url: endpoint, cachePolicy: .returnCacheDataElseLoad)
        } else {
            request = URLRequest(url: endpoint, cachePolicy: .reloadIgnoringCacheData)
        }

        guard let urlRequest = request else {
            return
        }

        networkManager.perform(urlRequest, for: ListCurrencyResponse.self) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let list):
                os_log("CurrencyConverterViewModel fetched /list results.", log: .networking, type: .debug)
                self.lastListResponse = list
            case .failure(let error):
                if error == .decodingFailed {
                }
                os_log("CurrencyConverterViewModel failed to fetch /list results.", log: .networking, type: .debug)
            }
        }
    }

    //- MARK: Conversion
    /// Converts an amount from one currency to another.
    /// - Parameter amount: The amount to be converted.
    private func convert(_ amount: String) -> String {
        guard let amountDouble = Double(amount) else {
            return ""
        }

        if toCurrencyStorage == "USD" {
            return convertToUSD(amountDouble)
        }

        if fromCurrencyStorage == "USD" {
            return convertFromUSD(amountDouble)
        }

        guard let fromCurrencyUSDValue = quotes[fromCurrencyStorage] else {
            return ""
        }

        guard let toCurrencyUSDValue = quotes[toCurrencyStorage] else {
            return ""
        }

        let fromCurrencyToUSD = fromCurrencyUSDValue

        let converted =  (toCurrencyUSDValue/fromCurrencyToUSD) * amountDouble

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Converts an amount to `USD`.
    private func convertToUSD(_ amount: Double) -> String {
        guard let usdValue = quotes[fromCurrencyStorage] else {
            return ""
        }
        let converted = amount * usdValue

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Converts an amount from `USD`.
    private func convertFromUSD(_ amount: Double) -> String {
        guard let usdValue = quotes[toCurrencyStorage] else {
            return ""
        }
        let currencyValue = 1/usdValue
        let converted = amount * currencyValue

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Trimms the keys for the quotes.
    private func trimmedQuotes(_ quotes: Quotes) -> Quotes {
        var trimmedQuotes = [String: Double]()
        for key in quotes.keys {
            var trimmedKey = key
            trimmedKey.removeFirst(3)
            trimmedQuotes[trimmedKey] = quotes[key]
        }
        return trimmedQuotes
    }
}
