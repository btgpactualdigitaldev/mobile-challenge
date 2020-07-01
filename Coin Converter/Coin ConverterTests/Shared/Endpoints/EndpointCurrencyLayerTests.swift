//
//  EndpointCurrencyLayerTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class EndpointCurrencyLayerTests: XCTestCase {

    func testList() {
        let endpoint: Endpoint.CurrencyLayer = .list
        
        let expectedEndpoint: String = "http://api.currencylayer.com/list"
        XCTAssertEqual(expectedEndpoint, endpoint.url.absoluteString)
        
        let expectedMethod: HTTPMethod = .get
        XCTAssertEqual(expectedMethod, endpoint.method)
        
        let expectedHeader: [String: String] = [:]
        XCTAssertEqual(expectedHeader, endpoint.headers)
        
        let expectedParameters: [String: String] = ["access_key": Endpoint.CurrencyLayer.accessToken]
        XCTAssertEqual(expectedParameters, endpoint.parameters)
        
        let expectedCustomBody: Data? = nil
        XCTAssertEqual(expectedCustomBody, endpoint.customBody)
    }
    
    func testLive() {
        let endpoint: Endpoint.CurrencyLayer = .live
        
        let expectedEndpoint: String = "http://api.currencylayer.com/live"
        XCTAssertEqual(expectedEndpoint, endpoint.url.absoluteString)
        
        let expectedMethod: HTTPMethod = .get
        XCTAssertEqual(expectedMethod, endpoint.method)
        
        let expectedHeader: [String: String] = [:]
        XCTAssertEqual(expectedHeader, endpoint.headers)
        
        let expectedParameters: [String: String] = ["access_key": Endpoint.CurrencyLayer.accessToken]
        XCTAssertEqual(expectedParameters, endpoint.parameters)
        
        let expectedCustomBody: Data? = nil
        XCTAssertEqual(expectedCustomBody, endpoint.customBody)
    }

}
