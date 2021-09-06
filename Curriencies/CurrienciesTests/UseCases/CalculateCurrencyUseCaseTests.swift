//
//  CalculateCurrencyUseCaseTests.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

import XCTest
@testable import Curriencies

final class CalculateCurrencyUseCaseTests: XCTestCase {
    lazy var sut = CalculateCurrencyUseCase()
    
    let currencyDummy: [CurrencyEntity] = [
        CurrencyEntity(code: "BRL", name: "Brazilian Real", value: 5),
        CurrencyEntity(code: "ABC", name: "American Dolar", value: 2)
    ]

    func testCalculateCurrency_WhenNoCurrencies_ShouldReturnOriginValue() {
        let emptyCurrencyDummy: [CurrencyEntity] = []
        
        let value = sut.calculateCurrency(currencies: emptyCurrencyDummy,
                                          originCode: "ABC",
                                          destinationCode: "BRL",
                                          originValue: 20)
        
        XCTAssertEqual(value, 20)
    }
    
    func testCalculateCurrency_WhenOriginCodeNotFound_ShouldReturnDestinationDolarQuote() {
        let value = sut.calculateCurrency(currencies: currencyDummy,
                                          originCode: "EUR",
                                          destinationCode: "BRL",
                                          originValue: 2)
        
        XCTAssertEqual(value, 10)
    }
    
    func testCalculateCurrency_WhenDestinationCodeNotFound_ShouldReturnOriginDolarQuote() {
        let value = sut.calculateCurrency(currencies: currencyDummy,
                                          originCode: "ABC",
                                          destinationCode: "EUR",
                                          originValue: 10)
        
        XCTAssertEqual(value, 5)
    }
    
    func testCalculateCurrency_WhenOriginValueIsNegative_ShouldReturnPositiveQuote() {
        let value = sut.calculateCurrency(currencies: currencyDummy,
                                          originCode: "ABC",
                                          destinationCode: "BRL",
                                          originValue: -10)
        
        XCTAssertEqual(value, 25)
    }
    
    func testCalculateCurrency_WhenHasCurrencyAndCodesFound_ShouldReturnQuote() {
        let value = sut.calculateCurrency(currencies: currencyDummy,
                                          originCode: "ABC",
                                          destinationCode: "BRL",
                                          originValue: 10)
        
        XCTAssertEqual(value, 25)
    }
}
