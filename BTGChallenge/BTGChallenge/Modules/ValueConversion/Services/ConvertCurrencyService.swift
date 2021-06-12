//
//  ConvertCurrencyService.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 15/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

protocol CurrencyLiveServiceContract {
    var provider: MoyaProvider<ConvertCurrencyRouter> { get set }
    func fetch(completion: @escaping(Result<CurrencyLiveModel>) -> Void)
}

class CurrencyLiveService: CurrencyLiveServiceContract {
    var provider: MoyaProvider<ConvertCurrencyRouter>
    
    init(provider: MoyaProvider<ConvertCurrencyRouter>) {
        self.provider = provider
    }
    
    func fetch(completion: @escaping (Result<CurrencyLiveModel>) -> Void) {
        provider.request(.live) { result in
            switch result {
            case .success(let moyaResponse):
                do {
                let result = try moyaResponse.map(CurrencyLiveModel.self, atKeyPath: nil, using: JSONDecoder())
                completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
