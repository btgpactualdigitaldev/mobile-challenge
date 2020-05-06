//
//  CurrencyLayerTests.swift
//  NetworkingTests
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Models
import Combine
import Service
@testable import Networking

fileprivate let testCurrencies = [
    Currency(abbreviation: "AED", fullName: "United Arab Emirates Dirham"),
    Currency(abbreviation: "AFN", fullName: "Afghan Afghani"),
    Currency(abbreviation: "ALL", fullName: "Albanian Lek"),
    Currency(abbreviation: "AMD", fullName: "Armenian Dram"),
    Currency(abbreviation: "ANG", fullName: "Netherlands Antillean Guilder")
].sorted()

fileprivate let testQuotes = [
    Quote("USD", "AUD", 1.278342),
    Quote("USD", "EUR", 1.278342),
    Quote("USD", "GBP", 0.908019),
    Quote("USD", "PLN", 3.731504)
].sorted()

class CurrencyLayerTests: XCTestCase {

    func testSupportedCurrenciesSuccessfulResponse() {
        let bundle = Bundle(identifier: "com.almeidaws.Currency.NetworkingTests")!
        let fileURL = bundle.url(forResource: "supported_currencies_successful", withExtension: "txt")!
        let data = try! Data(contentsOf: fileURL)
        Services.default.register(Requester.self) { MockedRequester(mock: .success(RequestResponse(data: data, status: .ok, request: URLRequest(url: fileURL)))) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        _ = requester.supportedCurrencies(bundle).sink(receiveCompletion: { completion in }) { currencies in
            assert(testCurrencies == currencies.sorted(), "Read currencies aren't equal to the expected.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testRealTimeQuotesSuccessfulResponse() {
        let bundle = Bundle(identifier: "com.almeidaws.Currency.NetworkingTests")!
        let fileURL = bundle.url(forResource: "real_time_rates_successful", withExtension: "txt")!
        let data = try! Data(contentsOf: fileURL)
        Services.default.register(Requester.self) { MockedRequester(mock: .success(RequestResponse(data: data, status: .ok, request: URLRequest(url: fileURL)))) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        _ = requester.realTimeRates(bundle).sink(receiveCompletion: { completion in }) { quotes in
            assert(testQuotes == quotes.sorted(), "Read quotes aren't equal to the expected.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 0.1)
    }
}
