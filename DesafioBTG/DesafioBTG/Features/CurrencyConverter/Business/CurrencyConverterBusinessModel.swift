//
//  CurrencyConverterBusinessModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class CurrencyConverterBusinessModel: CurrencyConversionProtocol, CurrencySelectorProtocol {    
    private let repository: CurrencyConverterRepository = CurrencyConverterRepository()
    
    var currencies: BehaviorSubject<[Currency]> = BehaviorSubject(value: [])
    var hasCurrencies: Bool {
        do {
            return try !currencies.value().isEmpty
        } catch {
            debugPrint(error)
            return false
        }
        
    }
    
    let fistSelectedCurrency:  BehaviorSubject<Currency?> = BehaviorSubject(value: nil)
    let secondSelectedCurrency:  BehaviorSubject<Currency?> = BehaviorSubject(value: nil)
    
    func rx_liveCurrencyValuesOfUSD() -> Observable<JSON> {
        repository.liveCurrencyValuesOfUSD().map { json -> JSON in
            json["quotes"]
        }
    }
    
    func rx_currenciesList() -> Observable<[Currency]> {
        repository.currenciesList().map { json -> [Currency] in
            json["currencies"].map { object -> Currency in
                let dictionary: [String: Any] = [object.0: object.1.stringValue]
                return Currency(json: dictionary)
            }
        }
    }
    
    func updateCurrency(value: Double, by code: String) {
        do {
            var currencies = try self.currencies.value()
            if let row = currencies.firstIndex(where: { $0.code == code }) {
                currencies[row].valueOfUSD = value
                self.currencies.onNext(currencies)
                let firstCurrencyCode = try fistSelectedCurrency.value()?.code
                let secondCurrencyCode = try secondSelectedCurrency.value()?.code
                if code == firstCurrencyCode{
                    self.fistSelectedCurrency.onNext(currencies[row])
                } else if code == secondCurrencyCode {
                    self.secondSelectedCurrency.onNext(currencies[row])
                }
            }
        } catch {
            debugPrint(error)
        }
    }
}
