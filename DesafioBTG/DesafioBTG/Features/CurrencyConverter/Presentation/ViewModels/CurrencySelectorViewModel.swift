//
//  CurrencySelectorViewModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift

class CurrencySelectorViewModel: DefaultViewModel<CurrencySelectorProtocol> {
    func rx_updateCurrenciesList() -> Observable<Void> {
        self.getBusinessModel().rx_currenciesList().map { newCurrencies -> Void in
            self.getBusinessModel().currencies.onNext(newCurrencies)
            return
        }
    }
    
    func getCurrencies() -> [Currency] {
        do {
            return try self.getBusinessModel().currencies.value()
        } catch {
            return []
        }
    }
    
    func setFirstCurrency(_ selectedCurrency: Currency) {
        self.getBusinessModel().fistSelectedCurrency.onNext(selectedCurrency)
    }
    
    func setSecondCurrency(_ selectedCurrency: Currency) {
        self.getBusinessModel().secondSelectedCurrency.onNext(selectedCurrency)
    }
}

