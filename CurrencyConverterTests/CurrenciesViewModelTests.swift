//
//  CurrenciesViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
@testable import Currencies
import Nimble
import RxNimble
import RxTest
import Quick
import RxSwift

class CurrenciesViewModelTests: QuickSpec {
    override func spec() {
        describe("CurrenciesViewModel") {
            var vm: CurrenciesViewModel!
            var service: CurrenciesDataServiceMock!
            var persistence: CurrenciesPersistenceMock!
            var mock: CurrenciesMock!
            
            beforeEach {
                service = CurrenciesDataServiceMock()
                persistence = CurrenciesPersistenceMock()
                mock = CurrenciesMock()
                vm = CurrenciesViewModel(currenciesService: service, currenciesPersistence: persistence)
                vm.currencies.accept(mock.getCurrencies())
            }

            context("fetchCurrencies()") {
                it("should get currencies and quotes") {
                    expect(vm.currencies).first.toNot(equal([]))
                }
            }
            
            context("tapCurrency() when not is selected") {
                beforeEach {
                    let _ = vm.tapCurrency(mock.fromCurrency)
                }
                it("should set from currency") {
                    expect(vm.fromText).first.to(equal(mock.fromCurrency.name))
                }
            }
            
            context("tapCurrency() when from is selected") {
                beforeEach {
                    vm.fromText.accept(mock.fromCurrency.name)
                    let _ = vm.tapCurrency(mock.toCurrency)
                }
                it("should set to currency") {
                    expect(vm.toText).first.to(equal(mock.toCurrency.name))
                }
            }
            
            context("tapClean()") {
                beforeEach {
                    vm.fromText.accept(mock.fromCurrency.name)
                    vm.toText.accept(mock.toCurrency.name)
                    vm.fromCurrency.accept(mock.fromCurrency)
                    vm.toCurrency.accept(mock.toCurrency)
                    vm.converterEnabled.accept(true)
                    vm.cleanEnabled.accept(true)
                    vm.tapClean()
                }
                it("should clean properties") {
                    expect(vm.fromText).first == ""
                    expect(vm.toText).first == ""
                    expect(vm.converterEnabled).first.to(beFalse())
                    expect(vm.cleanEnabled).first.to(beFalse())
                }
            }
            
            context("sameCurrency()") {
                beforeEach {
                    vm.fromText.accept(mock.fromCurrency.name)
                }
                it("should check if selecting same currency from and to") {
                    //same currency selected in from
                    let same = vm.sameCurrency(toCurrency: mock.fromCurrency)
                    expect(same).to(beTrue())
                }
            }
        }
    }
}
