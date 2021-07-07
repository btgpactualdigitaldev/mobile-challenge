//
//  CurrencyAPIServiceTests.swift
//  CurrencyConverterUnitTests
//
//  Created by Isnard Silva on 02/12/20.
//

import XCTest
@testable import CurrencyConverter

class CurrencyAPIServiceTests: XCTestCase {
    var sut: CurrencyAPIService!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyAPIService()
    }
    
    func testFetchCurrencyNames() {
        // Given
        var currencyNames: [String: String]?
        let promise = expectation(description: "Completion handler to fetch currency names")
        
        
        // When
        sut.fetchCurrencyNames(completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let receivedCurrencyNames):
                currencyNames = receivedCurrencyNames
            }
            
            promise.fulfill()
        })
        
        
        // Then
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(currencyNames)
        if let validCurrencyNames = currencyNames, validCurrencyNames.isEmpty {
            XCTFail("Currency Names is Empty")
        }
    }
    
    func testFetchCurrencyValuesInDollar() {
        // Given
        let promise = expectation(description: "Completion handler to fetch currency values")
        var currencyValuesInDollar: [String: Double]?
        
        // When
        sut.fetchCurrencyValuesInDollar(completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let receivedCurrencyValues):
                currencyValuesInDollar = receivedCurrencyValues
            }
            
            promise.fulfill()
        })
        
        // Then
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(currencyValuesInDollar)
        if let validCurrencyValues = currencyValuesInDollar, validCurrencyValues.isEmpty {
            XCTFail("Currency Values in Dollar is empty")
        }
    }
    
    func testFetchAllCurrencies() {
        // Given
        let promise = expectation(description: "Completion handle to fetch currencies")
        var currencies: [Currency]?
        
        sut.fetchAllCurrencies(completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let receivedCurrencies):
                currencies = receivedCurrencies
            }
            
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(currencies)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
