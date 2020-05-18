//
//  CoinConvertViewModel.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol CoinConvertViewModelDataStore: class {
    var fromCoinNickname: String { get set }
    var fromCoinValue: String { get set }
    var toCoinNickname: String { get set }
    var selectedCoinType: CoinType? { get set }
}

protocol CoinConvertViewModelInput: ViewModelInput {
    func getConversionQuote()
    func updateFromCoinValue(value: String)
    func updateSelectedCoinType(type: CoinType)
    func updateCoinNickname(nickname: String)
}

protocol CoinConvertViewModelOutput: ViewModelOutput {
    func displayAlertMessage(message: String)
    
    func displayFromCoinNickname(coinNickname: String)
    func displayToCoinNickname(coinNickname: String)
    func displayConversionValue(conversionValue: String)
}

final class CoinConvertViewModel: CoinConvertViewModelDataStore {
    
    // MARK: - Properties
    
    var fromCoinNickname = "BRL"
    var fromCoinValue = "0.00"
    var toCoinNickname = "USD"
    var selectedCoinType: CoinType?
    
    fileprivate let repository: CurrencyRepository
    weak var viewController: CoinConvertViewModelOutput?
    
    init(repository: CurrencyRepository) {
        self.repository = repository
    }
    
}

// MARK: - Inputs
extension CoinConvertViewModel: CoinConvertViewModelInput {
    func viewDidLoad() {
        
    }
    
    func getConversionQuote() {
        viewController?.displayLoadingView()
        repository
            .live(fromCoinNickname, toCoinNickname) { [weak self] liveResult in
                self?.viewController?.hideLoadingView()
                
                switch liveResult {
                case .success(let liveResponse):
                    self?.displayConversionValue(liveResponse: liveResponse)
                case .failure:
                    self?.displayAlertMessage(message: Constants.Errors.apiDefaultMessage)
                }
            }
    }
    
    func updateFromCoinValue(value: String) {
        fromCoinValue = value
    }
    
    func updateSelectedCoinType(type: CoinType) {
        selectedCoinType = type
    }
    
    func updateCoinNickname(nickname: String) {
        if selectedCoinType == .to {
            toCoinNickname = nickname
            displayToCoinNickname(coinNickname: nickname)
        } else {
            fromCoinNickname = nickname
            displayFromCoinNickname(coinNickname: nickname)
        }
    }
}

// MARK: - Outputs
extension CoinConvertViewModel {
    func displayFromCoinNickname(coinNickname: String) {
        viewController?.displayFromCoinNickname(coinNickname: coinNickname)
    }
    
    func displayToCoinNickname(coinNickname: String) {
        viewController?.displayToCoinNickname(coinNickname: coinNickname)
    }
    
    func displayConversionValue(liveResponse: LiveResponse) {
        let quote = liveResponse.quotes?[toCoinNickname + fromCoinNickname] ?? 0.0
        let conversionValue = fromCoinValue.double * quote
        let formatedValue = BtgCurrencyFormatter.format(double: conversionValue)
        
        viewController?.displayConversionValue(conversionValue: formatedValue)
    }
    
    func displayAlertMessage(message: String) {
        viewController?.displayAlertMessage(message: message)
    }
}
