//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

protocol CurrencyListViewModelDelegate: class {
    func didReceiveCurrencies()
    func didReceiveError(error: Error)
}

class CurrencyListViewModel {
    // MARK: - Properties
    private let currencyAPI = CurrencyAPIService()
    private let currencyDAO = CurrencyDAO()
    var currencies: [Currency]
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    
    // MARK: - Initialization
    init(currencies: [Currency]? = nil) {
        if let inputCurrencies = currencies {
            self.currencies = inputCurrencies
        } else {
            self.currencies = []
        }
    }
}


// MARK: - Fetch and Search Methods
extension CurrencyListViewModel {
    func fetchCurrencies() {
        currencyAPI.fetchAllCurrencies(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                // Verificando se há moedas salvas localmente
                if let currenciesSavedLocally = self?.getCurrenciesSavedLocally() {
                    self?.handleSuccess(savedCurrencies: currenciesSavedLocally)
                } else {
                    self?.handleErrors(error: error)
                }
                
            case .success(let receivedCurrencies):
                self?.handleSuccess(savedCurrencies: receivedCurrencies)
            }
        })
    }
    
    func searchCurrencies(searchText: String) -> [Currency] {
        let searchAttribute = searchText.lowercased()
        
        let filterSessions = currencies.filter {
            let currentCurrencyName = $0.name.lowercased()
            let currentCurrencyCode = $0.code.lowercased()
            return currentCurrencyName.contains(searchAttribute) || currentCurrencyCode.contains(searchAttribute)
        }
        return filterSessions
    }
}

// MARK: - Sort Method
extension CurrencyListViewModel {
    private func sortCurrenciesByCode() {
        self.currencies.sort(by: {
            $0.code < $1.code
        })
    }
}

// MARK: - Handle Local Storage
extension CurrencyListViewModel {
    private func getCurrenciesSavedLocally() -> [Currency]? {
        do {
            let savedCurrencies = try currencyDAO.fetchCurrencies()
            return savedCurrencies
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    private func saveCurrenciesLocally() {
        do {
            try currencyDAO.saveCurrencies(currencies: self.currencies)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Handle Erros
extension CurrencyListViewModel {
    private func handleSuccess(savedCurrencies: [Currency]) {
        self.currencies = savedCurrencies
        self.sortCurrenciesByCode()
        self.saveCurrenciesLocally()
        self.delegate?.didReceiveCurrencies()
    }
    
    private func handleErrors(error: Error) {
        delegate?.didReceiveError(error: error)
    }
}
