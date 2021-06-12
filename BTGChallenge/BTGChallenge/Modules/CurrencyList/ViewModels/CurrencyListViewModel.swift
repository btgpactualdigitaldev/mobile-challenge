//
//  CurrencyListViewModel.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

protocol CurrencyListViewModelContract {
    func fetch(completion: @escaping(Result<[CurrencyListViewData]>) -> Void)
}

class CurrencyListViewModel: CurrencyListViewModelContract {

    let service: CurrencyListServiceContract
    
    init(service: CurrencyListServiceContract) {
        self.service = service
    }
    
    func fetch(completion: @escaping (Result<[CurrencyListViewData]>) -> Void) {
        self.service.fetch { result in
            switch result {
            case .success(let model):
                guard let currencies = model.currencies else { return }
                let viewData = self.formartList(currencies: currencies)
                completion(.success(viewData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func formartList(currencies: [String: String]) -> [CurrencyListViewData]{
        return currencies.compactMap { element in
            let formattedCurrency = CurrencyListViewData(currencyCode: element.key, currencyName: element.value)
            return formattedCurrency
            
        }.sorted(by: { $0.currencyCode < $1.currencyCode })
    }
}
