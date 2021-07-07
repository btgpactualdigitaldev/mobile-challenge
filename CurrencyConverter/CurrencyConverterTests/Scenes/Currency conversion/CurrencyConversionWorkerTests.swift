//
//  CurrencyConversionWorkerTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 11/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class CurrencyConversionWorkerTests: XCTestCase {
    var sut: CurrencyConversionWorker!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyConversionWorker()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testWorker_whenTheValuesHasTheSameUsdCurrencyQuote_returnsTheSameValue() {
        let expectedValue = 10.0
        
        let result = sut.convert(10.0,
                                 currency: USDCurrencyQuote(currencyInitials: "BRL", quote: 4),
                                 to: USDCurrencyQuote(currencyInitials: "ABC", quote: 4))
        
        XCTAssertEqual(expectedValue, result)
    }
    
    func testWorker_returnsTheCorrectValue() {
        let expectedValue = 40.0
        
        let result = sut.convert(10.0,
                                 currency: USDCurrencyQuote(currencyInitials: "USD", quote: 1.0),
                                 to: USDCurrencyQuote(currencyInitials: "BRL", quote: 4.0))
        
        XCTAssertEqual(expectedValue, result)
    }
    
    func testWorker_whenSourceQuoteGreaterThanResultQuote_returnsAValueLessThanSourceValue() {
        let sourceValue = 10.0
        
        let result = sut.convert(sourceValue,
                                 currency: USDCurrencyQuote(currencyInitials: "BRL", quote: 4.0),
                                 to: USDCurrencyQuote(currencyInitials: "USD", quote: 1.0))
        
        XCTAssertTrue(result < sourceValue)
    }
    
    func testWorker_whenSourceQuoteLessThanResultQuote_returnsAValueGreaterThanSourceValue() {
        let sourceValue = 10.0
        
        let result = sut.convert(sourceValue,
                                 currency: USDCurrencyQuote(currencyInitials: "USD", quote: 1.0),
                                 to: USDCurrencyQuote(currencyInitials: "BRL", quote: 4.0))
        
        XCTAssertTrue(result > sourceValue)
    }
}
