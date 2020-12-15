//
//  URLSessionProviderTests.swift
//  CurrencyConverterTests
//
//  Created by Italo Boss on 15/12/20.
//

import XCTest
@testable import CurrencyConverter

class URLSessionProviderTests: XCTestCase {
    
    var sut: URLSessionProvider!
    var session: URLSessionMock!
    
    override func setUpWithError() throws {
        super.setUp()
        session = URLSessionMock()
        sut = URLSessionProvider(session: session)
    }

    func test_requestCurrencyList_success() {
        let expectation = XCTestExpectation()
        
        session.json = """
        {
            "success": true,
            "currencies": {
                "BRL": "Brazilian Real",
                "USD": "United States Dollar"
            }
        }
        """
        
        sut.request(type: CurrencyLayerListResponse.self, service: CurrencyLayerService.list) { (result) in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success)
                XCTAssertFalse(response.currencies.isEmpty)
            case .failure(_):
                XCTFail("CurrencyList Request failed")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_requestCurrencyLive_success() {
        let expectation = XCTestExpectation()
        
        session.json = """
            {
                "success": true,
                "timestamp": 1607849824,
                "source": "USD",
                "quotes": {
                    "USDBRL": 5.066204
                }
            }
        """
        
        sut.request(type: CurrencyLayerLiveResponse.self, service: CurrencyLayerService.live(from: "USD", to: "BRL")) { (result) in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success)
                XCTAssertEqual(response.source, "USD")
                XCTAssertFalse(response.quotes.isEmpty)
            case .failure(_):
                XCTFail("CurrencyLive Request failed")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        session = nil
        super.tearDown()
    }

}
