//
//  ListNetworkTests.swift
//  CurrencyServicesTests
//
//  Created by Breno Aquino on 29/10/20.
//

import XCTest
@testable import CurrencyServices

class ListNetworkTests: XCTestCase {

    let accessKeyParam: [String: String] = ["access_key": "ef06b891def0317f86b874f22acf7852"]
    let url: String = "http://api.currencylayer.com/list"
    
    func testList() throws {
        let expectation = XCTestExpectation(description: "Succes request in http://api.currencylayer.com/list")
        CurrencylayerNetwork().list { result in
            switch result {
            case .success(let currencies):
                XCTAssert(!currencies.isEmpty)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLive() throws {
        let expectation = XCTestExpectation(description: "Succes request in http://api.currencylayer.com/live with BRL and EUR")
        CurrencylayerNetwork().values(currenciesCodes: ["BRL", "EUR"]) { result in
            switch result {
            case .success(let quotes):
                XCTAssert(!quotes.isEmpty)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
