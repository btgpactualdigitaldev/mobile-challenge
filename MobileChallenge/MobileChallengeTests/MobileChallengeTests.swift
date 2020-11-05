//
//  MobileChallengeTests.swift
//  MobileChallengeTests
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import XCTest
@testable import MobileChallenge

class MobileChallengeTests: XCTestCase {

    var exchangeViewModel: ExchangeViewModel!
    
    override func setUp() {
        super.setUp()
        exchangeViewModel = ExchangeViewModel()
        exchangeViewModel.usedExchanges = ["BRL" : 5, "USD" : 1]
    }
    
    override func tearDown() {
        exchangeViewModel = nil
        super.tearDown()
    }
    
    func testExchangeResultWhenNotNumber() {
        
        let result = exchangeViewModel.exchangeResult(value: "a")
        
        XCTAssertEqual(result, 0)
    }
    
    func testExchangeResultWhenCorrect() {
        
        let result = exchangeViewModel.exchangeResult(value: "1")
        
        XCTAssertEqual(result, 5)
    }

    func testEqualTitlesWhenCorrect() {
        
        let result = exchangeViewModel.compareTitles(firstTitle: "test", secondTitle: "test")
        
        XCTAssertTrue(result)
    }
}
