//
//  CurrencyListViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Italo Boss on 14/12/20.
//

import Foundation

import XCTest
@testable import CurrencyConverter

class CurrencyListViewModelTests: XCTestCase {
    
    var sut: CurrencyListViewModel!
    var mockProvider: CurrencyListMockProvider!
    
    override func setUpWithError() throws {
        super.setUp()
        mockProvider = CurrencyListMockProvider()
        sut = CurrencyListViewModel(provider: mockProvider)
        sut.loadCurrencyList()
    }

    func test_currienciesCount_success() {
        XCTAssertEqual(sut.currienciesCount(), 2)
    }
    
    func test_getCurrencyAt_success() {
        XCTAssertNotNil(sut.getCurrencyAt(index: 0).code)
        XCTAssertNotNil(sut.getCurrencyAt(index: 1).code)
    }
    
    func test_selectCurrencyAt_success() {
        let expectation = XCTestExpectation()
        sut.selectedCurrency = { (currency) in
            XCTAssertNotNil(currency.code)
            expectation.fulfill()
        }
        sut.selectCurrencyAt(index: 0)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_searchCurrenciesFor_success() {
        sut.searchCurrenciesFor(name: "real")
        XCTAssertEqual(sut.currienciesCount(), 1)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }

}
