//
//  CurrenciesDataServiceMock.swift
//  CurrencyConverterTests
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
@testable import Currencies

class CurrenciesDataServiceMock: CurrenciesServiceRepository {
    func getCurrencies() -> Single<[CurrencyModel]> {
        return Observable<[CurrencyModel]>.create { observer in
            let currencies = CurrenciesMock().getCurrencies()            
            observer.on(.next(currencies))
            return Disposables.create()
        }.asSingle()
    }
}
