//
//  ConvertCurrencyTests.swift
//  Apply-BTGTests
//
//  Created by Adriano Rodrigues Vieira on 24/05/21.
//

import XCTest
@testable import Apply_BTG

class ConvertCurrencyTests: XCTestCase {
    let oneDollar: Double = 1.0
    // obtive esse valor copiando e colando da API, infelizmente eh a unica forma de testar
    let valueOfDollarInReal: Double = 5.342801

    var sut: ConversionQuotesManager?
    
    override func setUpWithError() throws {
        sut = ConversionQuotesManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testConvertDollarToAnotherSuccessfully() throws {
        XCTAssertTrue(sut?.convert(value: oneDollar, from: "USD", to: "BRL") == valueOfDollarInReal)
    }
    
    func testConvertAnotherToDollarSuccessfully() throws {
        XCTAssertTrue(sut?.convert(value: valueOfDollarInReal, from: "BRL", to: "USD") == oneDollar)
    }
    
    
    func testConvertDollarToRealWithError() throws {
        let oneDollarInBitcoin: Double = 0.000018313373
        
        XCTAssertFalse(sut?.convert(value: oneDollar, from: "USD", to: "BRL") == oneDollarInBitcoin)
    }
    
    func testConvertAnotherToDollarWithError() throws {
        let oneDollarInBitcoin: Double = 0.000018313373
        
        XCTAssertFalse(sut?.convert(value: valueOfDollarInReal, from: "BRL", to: "USD") == oneDollarInBitcoin)
    }
}
