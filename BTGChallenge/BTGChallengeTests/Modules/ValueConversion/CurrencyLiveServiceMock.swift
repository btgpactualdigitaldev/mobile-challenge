//
//  CurrencyLiveServiceMock.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya
import UIKit
@testable import BTGChallenge

class CurrencyLiveServiceMock: CurrencyLiveServiceContract {
    var provider: MoyaProvider<ConvertCurrencyRouter> = MoyaProvider<ConvertCurrencyRouter>()
    
    func fetch(completion: @escaping (Result<CurrencyLiveModel>) -> Void) {
        
        let quotes: [String: Double] = ["moeda 1": 3.9, "moeda2": 2.7, "moeda3": 0.5]
        let model = CurrencyLiveModel(terms: "test", privacy: "teste", timestamp: 2040, source: "Teste", quotes: quotes)
        completion(.success(model))
    }
}
