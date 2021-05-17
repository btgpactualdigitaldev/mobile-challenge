//
//  CurrencysViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import Foundation

class CurrencysViewModel: GenericModel {
    
    // MARK: - Attributes
    var updateCurrencies: () -> Void = { }
    var updateErrorMessage: () -> Void = {}
    var errorMessage: String = ""
    var loading: Bool = false
    private var orderBy: CurrenciesOrder = .name
    private var repository: CurrencyRepositoryProtocol
    private var currencies = [Currency]()
    private var filteredCurrencies = [Currency]() {
        didSet {
            DispatchQueue.main.async {
                self.updateCurrencies()
            }
        }
    }
    
    // MARK: - Initializer
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.repository = currencyRepository
        super.init()
        self.getUpdatedCurrencies()
    }
    
    // MARK: - Private Methods
    private func getUpdatedCurrencies() {
        self.loading = true
        self.repository.getCurrencyList { [weak self] result in
            if let self = self {
                self.loading = false
                switch result {
                case .success(let currenciesObject):
                    self.currencies = self.getCurrenciesSortedBy(order: self.orderBy, currencies: currenciesObject.currencies)
                    self.filteredCurrencies = self.currencies
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    DispatchQueue.main.async {
                        self.updateErrorMessage()
                    }
                }

            }
        }
    }
    
    private func getCurrenciesSortedBy(order: CurrenciesOrder, currencies: [Currency]) -> [Currency] {
        var currenciesSorted: [Currency] = []
        switch order {
        case .code:
            currenciesSorted = currencies.sorted(by: {$0.code < $1.code})
        case .name:
            currenciesSorted = currencies.sorted(by: {$0.name < $1.name})
        }
        return currenciesSorted
    }
    
    // MARK: - Public Methods
    func orderCurrenciesBy(_ order: CurrenciesOrder) {
        self.orderBy = order
        self.filteredCurrencies = self.getCurrenciesSortedBy(order: order, currencies: self.filteredCurrencies)
    }
    
    func filterCurrenciesBy(text: String) {
        if text.isEmpty {
            self.filteredCurrencies = self.getCurrenciesSortedBy(order: self.orderBy, currencies: self.currencies)
        } else {
            self.filteredCurrencies = self.currencies.filter { $0.name.lowercased().contains(text.lowercased()) || $0.code.lowercased().contains(text.lowercased())
            }
        }
    }

    func currenciesCount() -> Int {
        return self.filteredCurrencies.count
    }
    
    func getCurrency(position: Int) -> Currency? {
        return position <= (filteredCurrencies.count - 1) ? self.filteredCurrencies[position] : nil
    }
    
    func dismiss() {
        self.router.dismiss()
    }
}
