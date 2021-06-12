//
//  ConvertCurrencyViewModel.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 15/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

protocol CurrencyLiveViewModelContract {
    func fetch(completion: @escaping(Result<[CurrencyLiveViewData]>) -> Void)
}

class CurrencyLiveViewModel: CurrencyLiveViewModelContract {

    let service: CurrencyLiveServiceContract
    
    init(service: CurrencyLiveServiceContract) {
        self.service = service
    }
    
    func fetch(completion: @escaping (Result<[CurrencyLiveViewData]>) -> Void) {
        self.service.fetch{ result in
            switch result {
            case .success(let model):
                guard let quotes = model.quotes else { return }
                let viewData = self.formartList(currencies: quotes)
                completion(.success(viewData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   func formartList(currencies: [String: Double]) -> [CurrencyLiveViewData]{
        return currencies.compactMap { element in
            let formattedCurrency = CurrencyLiveViewData(currencyCode: element.key, currencyQuote: element.value)
            return formattedCurrency
            
        }.sorted(by: { $0.currencyCode < $1.currencyCode })
    }
}
