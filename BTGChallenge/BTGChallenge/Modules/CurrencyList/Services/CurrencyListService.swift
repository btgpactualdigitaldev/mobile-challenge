//
//  CurrencyListService.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

protocol CurrencyListServiceContract {
    var provider: MoyaProvider<CurrencyListRoute> { get set }
    func fetch(completion: @escaping(Result<CurrencyListModel>) -> Void)
}

class CurrencyListService: CurrencyListServiceContract {
    var provider: MoyaProvider<CurrencyListRoute>
    
    init(provider: MoyaProvider<CurrencyListRoute>) {
        self.provider = provider
    }
    
    func fetch(completion: @escaping (Result<CurrencyListModel>) -> Void) {
        provider.request(.list) { result in
            switch result {
            case let .success(moyaresponse):
                do {
                    let result = try moyaresponse.map(CurrencyListModel.self, atKeyPath: nil, using: JSONDecoder())
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}

extension Data {
    var prettyPrinted: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else
        { return nil }
        return string
    }
}
