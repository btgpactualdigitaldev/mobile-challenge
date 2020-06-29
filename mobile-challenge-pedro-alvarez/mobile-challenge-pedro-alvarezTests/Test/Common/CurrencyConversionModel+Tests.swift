//
//  CurrencyConversionModel+Tests.swift
//  mobile-challenge-pedro-alvarezTests
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import mobile_challenge_pedro_alvarez

class CurrencyConversionModel_Tests: XCTestCase {

    var sut1: CurrencyConversionModel!
    var sut2: CurrencyConversionModel!
    
    override func setUp() {
        sut1 = CurrencyConversionModel(id: "COIN1", dolarValue: 2.5)
        sut2 = CurrencyConversionModel(id: "COIN2", dolarValue: 2.0)
    }
    
    
    override func tearDown() {
        sut1 = nil
        sut2 = nil
    }
    
    func testConvert() {
        let conversion = CurrencyConversionModel.convert(value: 1.0,
                                                         first: sut1,
                                                         second: sut2)
        let expectedResult: Double = 0.8
        XCTAssertEqual(conversion, expectedResult)
    }

    func testGetCurrencyConversions() {
        let expectedResult = 2
        let conversions = CurrencyConversionModel.getCurrencyConversions(["COIN1" : 1.0, "COIN2" : 1.0])
        XCTAssertEqual(expectedResult, conversions.count)
    }
}
