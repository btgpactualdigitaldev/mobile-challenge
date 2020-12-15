//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

protocol CurrencyConverterViewModeling {
    var delegate: CurrencyConverterViewModelDelegate? { get set }
    
    var fromCurrencyCode: String { get }
    var fromCurrencyName: String { get }
    var fromCurrencyValue: String? { get set }
    
    var toCurrencyCode: String { get }
    var toCurrencyName: String { get }
    var toCurrencyValue: String? { get }
    
    func getSelectFromCurrencyScene() -> CurrencyListViewController
    func getSelectToCurrencyScene() -> CurrencyListViewController
    func loadCurrencyLiveQuote()
    func convert(amount: String) -> String
    func swapCurrencies()
}

protocol CurrencyConverterViewModelDelegate: class {
    func updateUI()
    func presentError(with message: String)
    func shouldShowLoading(_ isLoading: Bool)
}

class CurrencyConverterViewModel: CurrencyConverterViewModeling {
    
    // MARK: - Properties
    // From Currency Properties
    
    var fromCurrencyValue: String? {
        didSet {
            toCurrencyValue = convert(amount: fromCurrencyValue ?? "0")
        }
    }
    var fromCurrencyCode: String = "USD" {
        didSet {
            loadCurrencyLiveQuote()
        }
    }
    var fromCurrencyName: String = "United States Dollar" {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    // To Currency Properties
    
    var toCurrencyValue: String? = "0.00" {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    var toCurrencyCode: String = "BRL" {
        didSet {
            loadCurrencyLiveQuote()
        }
    }
    var toCurrencyName: String = "Brazilian Real" {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    weak var delegate: CurrencyConverterViewModelDelegate?
    
    // MARK: - Private Properties
    
    private var quote: Double = 0 {
        didSet {
            toCurrencyValue = convert(amount: fromCurrencyValue ?? "0")
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    private let provider: Provider
    
    init(provider: Provider = URLSessionProvider()) {
        self.provider = provider
    }
    
    // MARK: - Protocol functions
    
    func loadCurrencyLiveQuote() {
        let fromCurrencyCode = self.fromCurrencyCode
        let toCurrencyCode = self.toCurrencyCode
        
        guard fromCurrencyCode != toCurrencyCode else {
            quote = 1
            return
        }
        delegate?.shouldShowLoading(true)
        provider.request(type: CurrencyLayerLiveResponse.self, service: CurrencyLayerService.live(from: fromCurrencyCode, to: toCurrencyCode)) { [weak self] (result) in
            self?.delegate?.shouldShowLoading(false)
            switch result {
            case .success(let response):
                self?.setResultQuote(from: response.quotes)
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
    
    func convert(amount: String) -> String {
        guard let amountDouble = Double(amount) else {
            return ""
        }
        
        let convertedAmount = convertValue(amountDouble)
        
        return String(format: "%.2f", convertedAmount)
    }
    
    func getSelectFromCurrencyScene() -> CurrencyListViewController {
        let currencyListViewModel = CurrencyListViewModel()
        currencyListViewModel.selectedCurrency = selectedFromCurrency
        
        let currencyListScene = CurrencyListViewController(viewModel: currencyListViewModel)
        return currencyListScene
    }
    
    func getSelectToCurrencyScene() -> CurrencyListViewController {
        let currencyListViewModel = CurrencyListViewModel()
        currencyListViewModel.selectedCurrency = selectedToCurrency
        
        let currencyListScene = CurrencyListViewController(viewModel: currencyListViewModel)
        return currencyListScene
    }
    
    func swapCurrencies() {
        let lastFromCurrencyCode = fromCurrencyCode
        let lastFromCurrencyName = fromCurrencyName
        
        fromCurrencyName = toCurrencyName
        toCurrencyName = lastFromCurrencyName
        
        fromCurrencyCode = toCurrencyCode
        toCurrencyCode = lastFromCurrencyCode
    }
    
    // MARK: - Private functions
    
    private func setResultQuote(from quotes: [String : Double]) {
        let fromQuote = quotes["USD\(fromCurrencyCode)"] ?? 0
        let toQuote = quotes["USD\(toCurrencyCode)"] ?? 0
        
        quote = (1/fromQuote) * toQuote
    }
    
    private func selectedFromCurrency(_ currency: Currency) {
        fromCurrencyName = currency.name
        fromCurrencyCode = currency.code
    }
    
    private func selectedToCurrency(_ currency: Currency) {
        toCurrencyName = currency.name
        toCurrencyCode = currency.code
    }
    
    private func convertValue(_ value: Double) -> Double {
        return value * quote
    }
    
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
    
}
