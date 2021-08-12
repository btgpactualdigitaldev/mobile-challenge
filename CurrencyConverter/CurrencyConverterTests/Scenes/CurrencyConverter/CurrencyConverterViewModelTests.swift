//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Italo Boss on 14/12/20.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterViewModelTests: XCTestCase {
    
    var sut: CurrencyConverterViewModel!
    var mockProvider: CurrencyConverterMockProvider!
    
    override func setUpWithError() throws {
        super.setUp()
        mockProvider = CurrencyConverterMockProvider()
        sut = CurrencyConverterViewModel(provider: mockProvider)
        sut.loadCurrencyLiveQuote()
    }

    func test_getSelectFromCurrencyScene_success() {
        let result = sut.getSelectFromCurrencyScene()
        XCTAssertNotNil(result.viewModel)
    }
    
    func test_getSelectToCurrencyScene_success() {
        let result = sut.getSelectToCurrencyScene()
        XCTAssertNotNil(result.viewModel)
    }
    
    func test_convert_success() {
        let result = sut.convert(amount: "1")
        XCTAssertEqual(result, "5.07")
    }
    
    func test_swapCurrencies_success() {
        let lastFromCurrencyCode = sut.fromCurrencyCode
        let lastToCurrencyCode = sut.toCurrencyCode
        
        sut.swapCurrencies()
        
        XCTAssertEqual(sut.fromCurrencyCode, lastToCurrencyCode)
        XCTAssertEqual(sut.toCurrencyCode, lastFromCurrencyCode)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }

}
