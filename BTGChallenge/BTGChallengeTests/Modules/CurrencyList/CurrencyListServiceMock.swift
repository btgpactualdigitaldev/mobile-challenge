//
//  CurrencyListServiceMock.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya
import UIKit
@testable import BTGChallenge

class CurrencyListServiceMock: CurrencyListServiceContract {
    
    var provider: MoyaProvider<CurrencyListRoute> = MoyaProvider<CurrencyListRoute>()
    
    func fetch(completion: @escaping (Result<CurrencyListModel>) -> Void) {
        let currency: [String: String] = ["BRL": "Brasil", "USD": "Estados Unidos", "UNK": "UNKNOW"]
        let model = CurrencyListModel(success: true, terms: "triste", privacy: "triste", currencies: currency)
        completion(.success(model))
    }
    
    
    
}
