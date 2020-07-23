//
//  ConversionTests.swift
//  CoinConversionTests
//
//  Created by Ronilson Batista on 23/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import XCTest
@testable import CoinConversion

class ConversionTests: XCTestCase {
    let window = UIWindow()
    private var conversionViewModel: ConversionViewModel!
    private var conversion: [ConversionCurrenciesModel] = []

    override func setUpWithError() throws {
        super.setUp()
        conversionViewModel = ConversionViewModel(
            service: CurrenciesConversionService(),
            dataManager: DataManager(),
            router: ConversionRouter(window: window)
        )
        
        let a = ConversionCurrenciesModel(code: "USDAED", quotes: 3.672993)
        let b = ConversionCurrenciesModel(code: "USDAFN", quotes: 77.100541)
        let c = ConversionCurrenciesModel(code: "USDALL", quotes: 107.297762)
        let d = ConversionCurrenciesModel(code: "USDAMD", quotes: 1.79476)
        
        conversion.append(a)
        conversion.append(b)
        conversion.append(c)
        conversion.append(d)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        conversionViewModel = nil
    }

    func testFetchQuotes() {
        let exp = self.expectation(description: "Wait for Request completion")
        var fail: ServiceError?
        var quotes: CurrenciesConversion?
        
        let service = CurrenciesConversionService()
        
        service.fetchQuotes(success: { currenciesConversion in
            quotes = currenciesConversion
            exp.fulfill()
        }) { serviceError in
            fail = serviceError
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNil(fail)
        XCTAssertNotNil(quotes)
        XCTAssert(quotes?.quotes.keys.count ?? 0 > 0, "quotes results")
    }
    
    func testFormatCurrency() {
        let convertCurrency = self.conversionViewModel?.formatCurrency(currencyCode: "EUR", amount: "100000")
        XCTAssertNotNil(convertCurrency)
    }
    
    func testCalculateConversion() {
        let expected = 3.4231776427918414
        let convertCurrency = self.conversionViewModel?.calculateConversion(value: 100.00, toQuotes: 3.672993, fromQuotes: 107.297762)
        XCTAssertEqual(convertCurrency, expected)
    }
    
    func testReturnQuotes() {
        let quotes = self.conversionViewModel.returnQuotes(conversion: conversion, currencyBase: "USD", code: "AED")
       XCTAssertNotNil(quotes)
    }
}
