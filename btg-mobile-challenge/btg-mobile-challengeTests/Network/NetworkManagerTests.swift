//
//  NetworkManagerTests.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 02/10/20.
// swiftlint:disable all

import XCTest
@testable import btg_mobile_challenge

final class NetworkManagerTests: XCTestCase {

    var service: NetworkServiceMock!
    var sut: NetworkManager!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        service = NetworkServiceMock(bundle: bundle)
        sut = NetworkManager(service: service)
    }

    func testPerfomLiveCurrency() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        let stubJSONData = try! Data(contentsOf: stubJSONURL!)

        service.json = stubJSONURL

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .success(let result):
                let stubJSON = try! JSONDecoder().decode(LiveCurrencyReponse.self, from: stubJSONData)
                XCTAssertEqual(stubJSON, result)
            case .failure(_):
                XCTFail("Expected request to succeed. Request failed")
            }
        }
    }

    func testPerfomListCurrency() {
        let urlRequest = URLRequest(url: Endpoint.list.url!)
        let stubJSONURL = service.bundle.url(forResource: "list-response", withExtension: "json")
        let stubJSONData = try! Data(contentsOf: stubJSONURL!)

        service.json = stubJSONURL
        
        sut.perform(urlRequest, for: ListCurrencyResponse.self) { (response) in
            switch response {
            case .success(let result):
                let stubJSON = try! JSONDecoder().decode(ListCurrencyResponse.self, from: stubJSONData)
                XCTAssertEqual(stubJSON, result)
            case .failure(_):
                XCTFail("Expected request to succeed. Request failed")
            }
        }
    }

    func testPerformFailed() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        service.shouldFail = true

        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        service.json = stubJSONURL

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(NetworkServiceError.requestFailed, error)
            case .success(_):
                XCTFail("Expected request to fail. Request succeeded.")
            }
        }
    }

    func testPerformUnexpectedResponse() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        service.unexpectedResponseType = true

        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        service.json = stubJSONURL

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(NetworkServiceError.unexpectedResponseType, error)
            case .success(_):
                XCTFail("Expected request to fail. Request succeeded.")
            }
        }
    }

    func testPerformUnexpectedStatusCode() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        service.statusCode = 404

        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        service.json = stubJSONURL

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(NetworkServiceError.unexpectedHTTPStatusCode, error)
            case .success(_):
                XCTFail("Expected request to fail. Request succeeded.")
            }
        }
    }

    func testPerformMissingData() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        service.missinData = true

        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        service.json = stubJSONURL

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(NetworkServiceError.missingData, error)
            case .success(_):
                XCTFail("Expected request to fail. Request succeeded.")
            }
        }
    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
}
