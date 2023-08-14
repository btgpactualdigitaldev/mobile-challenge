//
//  CurrencyConverterRepository.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

struct CurrencyConverterRequest {
    static let live = "/live"
    static let list = "/list"
}

class CurrencyConverterRepository {
    
    func currenciesList() -> Observable<JSON> {
        CurrencylayerCore.get(CurrencyConverterRequest.list).map { response -> JSON in
            JSON(response)
        }
    }
    
    func liveCurrencyValuesOfUSD() -> Observable<JSON> {
        CurrencylayerCore.get(CurrencyConverterRequest.live).map { response -> JSON in
            JSON(response)
        }
    }
}
