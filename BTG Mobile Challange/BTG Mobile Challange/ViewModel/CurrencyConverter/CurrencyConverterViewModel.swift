//
//  CurrencyConverterViewModel.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

public class CurrencyConverterViewModel {

    // MARK: - Bindable variables

    @Published var convertedValue: Double?

    // MARK: - Constants

    private let servicesProvider: CurrencyConverterServiceProtocol

    // MARK: - Variables

    private var quotes: [String: Double]?

    // MARK: - Lyfecycle and constructors

    init(servicesProvider: CurrencyConverterServiceProtocol) {
        self.servicesProvider = servicesProvider
        servicesProvider.fetchCurrencyQuotes { response in
            switch response {
            case .failure:
                self.quotes = nil
            case .success(let data):
                self.quotes = data.quotes
            }
        }
    }

    // MARK: - Public functions

    func convert(from origin: String, to destiny: String, value: Double) {
        guard let originRate = quotes?["USD\(origin)"],
            let destinyRate = quotes?["USD\(destiny)"] else { return }
        let invertedOriginRate = 1 / originRate

        self.convertedValue = value * invertedOriginRate * destinyRate
    }
}
