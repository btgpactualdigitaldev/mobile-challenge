//
//  StringTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class StringTests: XCTestCase {

    func testDigits(){
        let digitsFull: String = "a1"
        let digits: String = digitsFull.digits
        
        let expectedDigits: String = "1"
        XCTAssertEqual(expectedDigits, digits)
    }
    
    func testCurrency(){
        let fullValue: String = "1,000.00"
        let currency: String = fullValue.toCurrency()
        
        let expectedCurrency: String = " 1.000,00"
        XCTAssertEqual(expectedCurrency, currency)
    }

}
