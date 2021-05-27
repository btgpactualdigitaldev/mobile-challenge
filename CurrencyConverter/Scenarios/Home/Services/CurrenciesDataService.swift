//
//  CurrenciesDataService.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON

final class CurrenciesDataService: CurrenciesServiceRepository {
    private let provider = MoyaProvider<CurrenciesService>()
    private let disposeBag = DisposeBag()

    func getCurrencies() -> Single<[CurrencyModel]> {
        return Observable.combineLatest(
            provider.rx
                .request(.getCurrencies)
                .asObservable()
                .map { single in return try JSON(single.mapJSON()) },
            provider.rx
                .request(.getQuotes)
                .asObservable()
                .map { single in return try JSON(single.mapJSON()) })
        { (currenciesJSON: JSON, quotesJSON: JSON) -> [CurrencyModel] in
            var currencies: [CurrencyModel] = []

            for (key, subJson) in currenciesJSON["currencies"] {
                if let nameFull = subJson.string, let quote = quotesJSON["quotes"]["USD"  + key].double {
                    let currency = CurrencyModel()
                    currency.name = key
                    currency.nameFull = nameFull
                    currency.quote = quote
                    currencies.append(currency)
                }
            }

            return currencies
        }.asSingle()
    }
}
