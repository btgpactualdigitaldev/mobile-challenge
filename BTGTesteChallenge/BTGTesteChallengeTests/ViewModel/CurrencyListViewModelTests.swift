//
//  CurrencyListViewModelTests.swift
//  BTGTesteChallengeTests
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import XCTest
@testable import BTGTesteChallenge

class CurrencyListViewModelTests: XCTestCase {
    
    var currencyListFilepath: String!
    var sut: ListOfCurrencyViewModelProtocol!

    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        currencyListFilepath = testBundle.path(forResource: "CurrencyList", ofType: "json")
        sut = ListOfCurrencyViewModel(listCurrencyRepository: DummyListCurrencyRepository(), presentErrorDelegate: DummyViewController())
        
        if let data = FileManager().contents(atPath: currencyListFilepath),
            let currencyList = try? JSONDecoder().decode(CurrencyList.self, from: data),
            let currencies = currencyList.currencies {
            sut.currencyDictionary = currencies
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelShouldReturnTotalOfCurrenciesHigherThanZeroIfLoadedCorrectly() {
        XCTAssertTrue(sut.totalOfCurrencies() > 0)
    }
    
    func testShouldReturnKeysIfValidCurrencyList() {
        XCTAssertNotNil(sut.currencyDictionary)
        XCTAssertNotNil(sut.currencyList)
        XCTAssertTrue(sut.currencyList.count > 0)
    }
    
    func testShouldReturnValuesIfValidCurrencyList() {
        XCTAssertNotNil(sut.currencyDictionary)
        XCTAssertNotNil(sut.currencyList)
        XCTAssertTrue(sut.currencyList.count > 0)
    }

}
