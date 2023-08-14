//
//  CurrencyConversionViewModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift

class CurrencyConversionViewModel: DefaultViewModel<CurrencyConversionProtocol> {
    
    let disposeBag = DisposeBag()
    
    func rx_updateListValues() -> Observable<Void> {
        if self.getBusinessModel().hasCurrencies {
            return self.getBusinessModel().rx_liveCurrencyValuesOfUSD().map { json -> Void in
                for updatedCurrency in json {
                    guard let value = updatedCurrency.1.double else { continue }
                    let code = String(updatedCurrency.0.dropFirst(3))
                    self.getBusinessModel().updateCurrency(value: value, by: code)
                }
            }
        } else {
            return Observable.just(())
        }
    }
    
    func getFirstCurrency() -> Currency? {
        do {
            return try self.getBusinessModel().fistSelectedCurrency.value()
        } catch {
            return nil
        }
    }
    
    func getSecondCurrency() -> Currency? {
        do {
            return try self.getBusinessModel().secondSelectedCurrency.value()
        } catch {
            return nil
        }
    }
    
    func bindFirstCurrencyTo(label: UILabel) {
        self.getBusinessModel().fistSelectedCurrency.subscribe { event in
            guard let currency = event.element else { return }
            label.text = currency?.name
        }.disposed(by: self.disposeBag)
    }
    
    func bindSecondCurrencyTo(label: UILabel) {
        self.getBusinessModel().secondSelectedCurrency.subscribe { event in
            guard let currency = event.element else { return }
            label.text = currency?.name
        }.disposed(by: self.disposeBag)
    }
    
    func rx_currencyChanged() -> Observable<(Currency?, Currency?)> {
        Observable.combineLatest(self.getBusinessModel().fistSelectedCurrency.asObservable(), self.getBusinessModel().secondSelectedCurrency.asObservable())
    }
}
