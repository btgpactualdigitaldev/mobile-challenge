//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

typealias Currency = (code: String, name: String)

protocol CurrencyListViewModeling {
    var delegate: CurrencyListViewModelDelegate? { get set }
    func loadCurrencyList()
    func currienciesCount() -> Int
    func getCurrencyAt(index: Int) -> Currency
    func selectCurrencyAt(index: Int)
    func searchCurrenciesFor(text: String)
}

protocol CurrencyListViewModelDelegate: class {
    func updateUI()
    func presentError(with message: String)
    func shouldShowLoading(_ isLoading: Bool)
    func close()
}

class CurrencyListViewModel: CurrencyListViewModeling {
    
    // MARK: - Properties
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    var selectedCurrency: ((Currency) -> Void)?
    
    private var currencies: [Currency] = [] {
        didSet {
            filteredCurrencies = currencies
        }
    }
    
    private var filteredCurrencies: [Currency] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    private let provider: Provider
    
    // MARK: - Initializer
    
    init(provider: Provider = URLSessionProvider()) {
        self.provider = provider
    }
    
    // MARK: - Logic Functions
    
    func loadCurrencyList() {
        delegate?.shouldShowLoading(true)
        provider.request(type: CurrencyLayerListResponse.self, service: CurrencyLayerService.list) { [weak self] (result) in
            self?.delegate?.shouldShowLoading(false)
            switch result {
            case .success(let response):
                self?.currencies = response.currencies.map({ ($0.key, $0.value) })
            case .failure(let error):
                guard let networkError = error as? NetworkError
                else {
                    self?.presentError()
                    break
                }
                self?.handleNetworkError(networkError)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func presentError(message: String = "Some error occurred.") {
        DispatchQueue.main.async {
            self.delegate?.presentError(with: message)
        }
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        switch error {
        case .apiError(let err):
            if let errorResponse = err as? ErrorResponse {
                presentError(message: errorResponse.error.info)
            } else {
                presentError()
            }
        default:
            presentError()
        }
    }
    
    // MARK: - Protocol functions
    
    func currienciesCount() -> Int {
        return filteredCurrencies.count
    }
    
    func getCurrencyAt(index: Int) -> Currency {
        return filteredCurrencies[index]
    }
    
    func selectCurrencyAt(index: Int) {
        let currency = getCurrencyAt(index: index)
        selectedCurrency?(currency)
        delegate?.close()
    }
    
    func searchCurrenciesFor(text: String) {
        filteredCurrencies = currencies.filter{
            text.isEmpty
                || $0.name.lowercased().contains(text.lowercased())
                || $0.code.lowercased().contains(text.lowercased())
        }
    }
    
}
