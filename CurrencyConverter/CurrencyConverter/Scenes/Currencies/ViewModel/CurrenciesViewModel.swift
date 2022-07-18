//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

protocol CurrenciesViewModelDelegate: AnyObject {
    func didFetchCurrencies()
    func didFailToFetchCurrencies()
}

protocol CurrenciesViewModelProtocol: AnyObject {
    var currenciesDelegate: CurrenciesViewModelDelegate? { get set }
    func getCurrencyName(index: Int) -> String?
    func getCurrencyInitials(index: Int) -> String?
    func currenciesCount() -> Int?
    func onLoad()
}

class CurrenciesViewModel: CurrenciesViewModelProtocol {

    weak var currenciesDelegate: CurrenciesViewModelDelegate?
    private var service: CurrenciesServiceProtocol
    private(set) var currencies: [Currencie]?
    
    init(service: CurrenciesServiceProtocol = CurrenciesServiceDefault()) {
        self.service = service
    }
    
    private var currenciesResponse: Currencies? {
        didSet {
            currencies = currenciesResponse?.currencies.map {
                Currencie(initials: $0.key, name: $0.value)
            } ?? []
            currencies = sortCurrencies()
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchCurrencies(completion: @escaping (Result<Bool, ServiceError>) -> Void) {
        service.fetchCurrencyList { result in
            switch result {
            case .success(let currencies):
                self.currenciesResponse = currencies
                completion(.success(true))
            case .failure(let err):
                debugPrint(err.localizedDescription)
                completion(.failure(.networkError("Could not fetch currencies")))
            }
        }
    }
    
    private func sortCurrencies() -> [Currencie] {
        guard let currencies = currencies else { return [] }
        return currencies.sorted {
            $0.name < $1.name
        }
    }
    
    // MARK: - Public Methods
        
    func getCurrencyName(index: Int) -> String? {
        guard let currency = currencies?[index] else { return "" }
        return currency.name
    }
    
    func getCurrencyInitials(index: Int) -> String? {
        guard let currency = currencies?[index] else { return "" }
        return currency.initials
    }
    
    func currenciesCount() -> Int? {
        guard let currencyList = currencies else { return 0 }
        return currencyList.count
    }
    
    func onLoad() {
        fetchCurrencies() { result in
            switch result {
            case .success:
                self.currenciesDelegate?.didFetchCurrencies()
            case .failure:
                self.currenciesDelegate?.didFailToFetchCurrencies()
            }
        }
    }
    
}
