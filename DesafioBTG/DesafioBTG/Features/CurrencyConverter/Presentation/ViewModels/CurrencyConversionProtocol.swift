//
//  CurrencyConversionProtocol.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

protocol CurrencyConversionProtocol {
    var hasCurrencies: Bool { get }
    var fistSelectedCurrency:  BehaviorSubject<Currency?> { get }
    var secondSelectedCurrency:  BehaviorSubject<Currency?> { get }
    
    func rx_liveCurrencyValuesOfUSD() -> Observable<JSON>
    func updateCurrency(value: Double, by code: String)
}
