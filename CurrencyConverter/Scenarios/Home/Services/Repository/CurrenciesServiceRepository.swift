//
//  CurrenciesRepository.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrenciesServiceRepository {
    func getCurrencies() -> Single<[CurrencyModel]>
}
