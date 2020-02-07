//
//  ListCurrencyRepositoryTests.swift
//  BTGTesteChallengeTests
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import XCTest
@testable import BTGTesteChallenge

class ListCurrencyRepositoryTests: XCTestCase {
    
    var sut: ListCurrencyRepositoryProtocol!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class
        sut = ListCurrencyRepository()
        sut.key = "68e904c6ff1193ea810f9a2450e7aaaa"
        sut.baseURL = "http://apilayer.net/api"
        sut.endpoint = .list
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRepositoryShouldFetchListOfCurrenciesForValidCredentials() {
        let expectation = XCTestExpectation(description: "expect to fetch data from server")
        sut.fetchListOfCurrency { [weak self] (result) in
            XCTAssertNotNil(self?.sut.url)
            var someError: Error!
            var listCurrency: CurrencyList!
            switch result {
            case .success(let currencyList):
                listCurrency = currencyList
            case .error(let error):
                someError = error
            }
            XCTAssertNotNil(listCurrency)
            XCTAssertNil(someError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }
    
    func testShouldFetchCurrencyListAndReturnInvalidIFInvalidCredentials() {
        sut.key = "sadasdasdasdasdasda"
        var someError : Error!
        let expectation = XCTestExpectation(description: "expect to fetch data from server")
        sut.fetchListOfCurrency { [weak self] (result) in
            XCTAssertNotNil(self?.sut.url)
            switch result {
            case .success(let currencyRate):
                return
            case .error(let error):
                someError = error
            }
            XCTAssertNotNil(result)
            XCTAssertNotNil(someError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }
    
    
    

}
