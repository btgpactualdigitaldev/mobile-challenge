//
//  ListViewModel.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import Foundation
import CurrencyServices

protocol ListViewModelDelegate: class {
    func onListCurrenciesUpdate()
    func onError(_ error: String)
}

class ListViewModel {
    
    private let network: CurrencyServices.CurrencylayerNetwork
    private(set) lazy var retry: (() -> Void)? = nil
    
    var type: CurrencyType
    var currencies: [Currecy]
    var currenciesDisplayed: [Currecy] {
        didSet { delegate?.onListCurrenciesUpdate() }
    }
    weak var delegate: ListViewModelDelegate?
    
    // MARK: - Life Cycle
    init(type: CurrencyType) {
        self.type = type
        network = CurrencyServices.CurrencylayerNetwork()
        currencies = []
        currenciesDisplayed = []
    }
    
    // MARK: - Handlers
    func serach(for text: String) {
        guard !text.isEmpty else {
            currenciesDisplayed = currencies
            return
        }
        
        let lowerText = text.lowercased()
        currenciesDisplayed = currencies.filter { $0.code.lowercased().contains(lowerText) || $0.name.lowercased().contains(lowerText) }
    }
}

// MARK: - Requests
extension ListViewModel {
    func availableCurrrencies() {
        network.list { [weak self] result in
            switch result {
            case .success(let currencies):
                let currencies = currencies.compactMap { try? Currecy(code: $0.key, name: $0.value) }.sorted(by: { $0.code < $1.code })
                self?.currencies = currencies
                self?.currenciesDisplayed = currencies
                
            case .failure(let error):
                self?.retry = self?.availableCurrrencies
                self?.delegate?.onError(error.info)
            }
        }
    }
}
