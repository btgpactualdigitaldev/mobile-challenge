//
//  CurrencyConverterViewModel.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import Foundation
import Network

class CurrencyConverterViewModel {

    enum CurrencyType {
        case origin
        case target
    }

    @LocalStorage(key: .originCurrency) var localOriginCurrency: Currency?
    @LocalStorage(key: .targetCurrency) var localTargetCurrency: Currency?
    @LocalStorage(key: .quotes) var localQuotes: [String: Double]?
    @LocalStorage(key: .lastUpdate) var localLastUpdate: Date?

    private let monitor = NWPathMonitor()
    private var isConnected = false {
        didSet {
            getLiveRate()
        }
    }

    var onUpdate: () -> Void = { }

    private var service: CurrencyLiveRateService
    private var lastUpdate: Date?
    private let numberFormatter = NumberFormatter()
    private let dateFormatter = DateFormatter()

    private(set) var originCurrency: Currency {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }
    
    private(set) var targetCurrency: Currency {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }

    private var quotes = [String: Double]() {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }

    init(originCurrency: Currency = .brl,
         targetCurrency: Currency = .usd,
         service: CurrencyLiveRateService) {
        self.originCurrency = originCurrency
        self.targetCurrency = targetCurrency
        self.service = service

        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 6
        numberFormatter.currencySymbol = ""

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        getLiveRate()

        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
        let queue = DispatchQueue(label: .init())
        monitor.start(queue: queue)

        getSavedCurrencies()
    }

    /// Get saved currencies from Local Storage  (UserDefaults)
    private func getSavedCurrencies() {
        if let localOriginCurrency = localOriginCurrency {
            originCurrency = localOriginCurrency
        } else {
            localOriginCurrency = originCurrency
        }

        if let localTargetCurrency = localTargetCurrency {
            targetCurrency = localTargetCurrency
        } else {
            localTargetCurrency = targetCurrency
        }
    }

    /// Get the currency live rate from API
    func getLiveRate() {
        if isConnected {
            service.getCurrencyLiveRate { [weak self] result in
                switch result {
                case .success(let liveRate):
                    self?.quotes = liveRate.quotes
                    self?.lastUpdate = liveRate.lastUpdate

                    self?.localLastUpdate = liveRate.lastUpdate
                    self?.localQuotes = liveRate.quotes

                case .failure(let error):
                    print(error)
                }
            }

        } else {
            quotes = localQuotes ?? [:]
            lastUpdate = localLastUpdate
        }
    }

    /// Sets selected currency and calls onUpdate() to inform new changes
    /// - Parameters:
    ///   - currency: currency selected
    ///   - type: which currency shoud be set (origin or target currency)
    func setSelectedCurrency(_ currency: Currency, for type: CurrencyType) {
        switch type {
        case .origin:
            originCurrency = currency
            localOriginCurrency = currency
        case .target:
            targetCurrency = currency
            localTargetCurrency = currency
        }
        onUpdate()
    }

    /// Invert originCurrency and  targetCurrency
    func invertCurrencies() {
        let temp = localOriginCurrency
        localOriginCurrency = localTargetCurrency
        localTargetCurrency = temp

        originCurrency = localOriginCurrency ?? .brl
        targetCurrency = localTargetCurrency ?? .usd
    }

    /// Converts originCurrency value to targetCurrencyValue
    /// - Parameters:
    ///   - text: text containing the originCurrency value
    ///   - completion: closure to return the converted value
    func convert(text: String, completion: (String) -> Void) {
        guard let originCurrency = localOriginCurrency,
              let targetCurrency = localTargetCurrency,
              let quotes = localQuotes else { return }

        let usdSourceKey = "\(Currency.usd.code)\(originCurrency.code)"
        let targetKey = "\(Currency.usd.code)\(targetCurrency.code)"

        guard let usdSourceRate = quotes[usdSourceKey],
              let targetRate = quotes[targetKey] else {
            return
        }

        let value = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
        let convertedValue = value / usdSourceRate * targetRate

        guard let formattedText = numberFormatter.string(from: NSNumber(value: convertedValue)) else {
            return
        }
        
        completion(formattedText)
    }

    /// Gets the last update date in a formatted manner
    /// - Returns: lastUpdate
    func getLastUpdateDate() -> String {
        guard let lastUpdate = localLastUpdate else {
            return ""
        }
        return "Last update: \(dateFormatter.string(from: lastUpdate))\n(updates depends on API free plan features)"
    }
}
