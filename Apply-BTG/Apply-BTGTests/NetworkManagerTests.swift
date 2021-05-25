//
//  Apply_BTGTests.swift
//  Apply-BTGTests
//
//  Created by Adriano Rodrigues Vieira on 19/05/21.
//

import XCTest
@testable import Apply_BTG

class NetworkManagerTests: XCTestCase {
    // MARK: - SUT
    var sut: NetworkManager!
    
    // MARK: - SETUP METHODS
    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - URL STRING TESTS
    
    /// Ensures if a valid `string` `url` (a.k.a. "http://foo.com") return `true`
    /// - Throws: A failure in the assertion if the `string` could not be a valid `url`
    func testUrlWithValidString() throws {
        XCTAssertTrue(sut.canCreateAValidURL(from: Constants.BTG_LIST_ENDPOINT))
    }
    
    /// Ensures if a invalid `string` `url` (a.k.a. "Mombojombo") return `false`
    /// - Throws: A failure in the assertion if the `string` could be a valid `url`
    func testUrlWithInvalidString() throws {
        let safeUrlString = "Warren Buffett"        
        XCTAssertFalse(sut.canCreateAValidURL(from: safeUrlString))
    }
        
    // MARK: - FETCHING TESTS
    
    /// Ensures if the object communicates with the `api` in order to obtain the list of currencies.
    /// - Throws: A failure in the assertion if no list is attributed in the var.
    func testFetchCurrenciesListDataSuccessfully() throws {
        var list: [Currency]?
        let expectation = self.expectation(description: "Esperando carregar a lista de moedas válidas...")
        
        let fetchData: currenciesListCompletion = { currenciesList in
            list = currenciesList
            expectation.fulfill()
        }
        sut.fetchCurrenciesList(completion: fetchData)
        
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(list)
    }
    
    /// Ensures if the list returned is not empty
    /// - Throws: A failure in the assertion if the list is empty
    func testFetchCurrenciesListDataNotEmpty() throws {
        var list: [Currency]?
        let expectation = self.expectation(description: "Esperando carregar a lista de moedas válidas...")
        
        let fetchData: currenciesListCompletion = { currenciesList in
            list = currenciesList
            expectation.fulfill()
        }
        sut.fetchCurrenciesList(completion: fetchData)
        
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssert(list?.count != 0)
    }
    
    /// Ensures a `CurrencyConversionList` data is fetched successfully
    /// - Throws: a failure in the assertion if the operation returns a `nil` object
    func testFetchConversionListDataSuccessfully() throws {
        var conversionList: ConversionQuotes?
        let expectation = self.expectation(description: "Esperando carregar a lista de cotações entre moedas")
        
        let fetchData: conversionListCompletion = { convList in
            conversionList = convList
            expectation.fulfill()
        }
        sut.fetchConversionList(completion: fetchData)
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertNotNil(conversionList)
    }
    
    func testFetchConversionListDataDictNotEmpty() throws {
        var conversionList: ConversionQuotes?
        let expectation = self.expectation(description: "Esperando carregar a lista de cotações entre moedas")
        
        let fetchData: conversionListCompletion = { convList in
            conversionList = convList
            expectation.fulfill()
        }
        sut.fetchConversionList(completion: fetchData)
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertTrue(conversionList?.all.count != 0)
    }
    
    // - MARK: CONNECTION TEST
        
    /// Ensures there is a internet connection
    /// - Throws: A failure in the assertion if the there is internet and the method sinalizes that there is no internet
    /// (**Note**: por testing purposes, please run this isolated and disconnect Mac's internet when testing the false assertion)
    func testInternetConnection() throws {
        XCTAssertTrue(sut.hasInternetConnection())
    }
}
