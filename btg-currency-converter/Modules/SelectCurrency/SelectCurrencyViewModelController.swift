//
//  SelectCurrencyModule.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 23/11/20.
//
import UIKit

class SelectCurrencyViewModelController {

    fileprivate var coinsViewModelList: [SelectCurrencyViewModel] = [SelectCurrencyViewModel]()
    
    func Coins() -> [SelectCurrencyViewModel] {
        return coinsViewModelList
    }
    
    func retrieveCoins(_ success: (() -> Void)?, failure: (() -> Void)?) {
        
        CoinService.shared.getCoins { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let model):
                if model.success {
                    var listCoins = [SelectCurrencyViewModel]()
                    if let currencies = model.currencies {
                        listCoins = currencies.map({ SelectCurrencyViewModel(source: $0.key, description: $0.value) })
                    }
                    
                    self?.coinsViewModelList = listCoins.sorted { $0.description < $1.description }
                    success?()
                } else {
                    failure?()
                }
            case .failure( _):
                failure?()
            }
        }
    }
}
