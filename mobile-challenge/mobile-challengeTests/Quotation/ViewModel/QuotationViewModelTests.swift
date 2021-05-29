//
//  QuotationViewModelTests.swift
//  mobile-challengeTests
//
//  Created by Caio Azevedo on 28/11/20.
//

import XCTest
@testable import mobile_challenge

class QuotationViewModelTests: XCTestCase {
    
    var sut: QuotationViewModel!

    override func setUp() {
        sut = QuotationViewModel()
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_convert(){
        let value = 10.0
        let origin = 5.34 //BRL
        let destiny = 0.84 // EUR
        
        let result = sut.convert(value: value, origin: origin, destiny: destiny)
        
        XCTAssertEqual(result, "1.57")
    }
    
    func test_groupCurrencyQuotationInfo(){
        let key = "BRL"
        let value = 5.34
        let currency = Currency(success: true, error: nil, currencies: [key : "BrazilianReal"])
        let quotation = Quotation(success: true, error: nil, timestamp: nil, quotes: ["USDBRL" : value])
        
        sut.currency = currency
        sut.quotation = quotation
        
        sut.groupCurrencyQuotationInfo()
        
        XCTAssertEqual(sut.currenciesQuotation.first?.code, key)
        XCTAssertEqual(sut.currenciesQuotation.first?.quotation, value)
    }

}
