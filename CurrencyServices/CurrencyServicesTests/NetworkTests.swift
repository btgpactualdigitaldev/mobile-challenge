//
//  NetworkTests.swift
//  CurrencyServicesTests
//
//  Created by Breno Aquino on 29/10/20.
//

import XCTest
@testable import CurrencyServices

class NetworkTests: XCTestCase {

    let accessKeyParam: [String: String] = ["access_key": "ef06b891def0317f86b874f22acf7852"]
    let baseUrl: String = "api.currencylayer.com"
    let path: String = "/list"
    
    func testCreateUrlHttp() throws {
        let url = Network.createUrl(scheme: .http, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(url?.absoluteString == "http://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong Creation")
    }
    
    func testCreateUrlHttps() throws {
        let url = Network.createUrl(scheme: .https, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(url?.absoluteString == "https://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong Creation")
    }
    
    func testCreateRequestGet() {
        let request = Network.createRequest(scheme: .http, method: .get, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(request?.url?.absoluteString == "http://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong URL")
        XCTAssert(request?.httpMethod == "GET", "Wrong Method")
    }
    
    func testCreateRequestPost() {
        let request = Network.createRequest(scheme: .http, method: .post, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(request?.url?.absoluteString == "http://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong URL")
        XCTAssert(request?.httpMethod == "POST", "Wrong Method")
    }
    
    func testCreateRequestPut() {
        let request = Network.createRequest(scheme: .http, method: .put, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(request?.url?.absoluteString == "http://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong URL")
        XCTAssert(request?.httpMethod == "PUT", "Wrong Method")
    }
    
    func testCreateRequestDelete() {
        let request = Network.createRequest(scheme: .http, method: .delete, baseUrl: baseUrl, path: path, params: accessKeyParam)
        XCTAssert(request?.url?.absoluteString == "http://api.currencylayer.com/list?access_key=ef06b891def0317f86b874f22acf7852", "Wrong URL")
        XCTAssert(request?.httpMethod == "DELETE", "Wrong Method")
    }
    
    func testRequestSuccess() {
        let expectation = XCTestExpectation(description: "Succes request in http://api.currencylayer.com/list")
        Network.request(method: .get, baseUrl: baseUrl, path: path, params: accessKeyParam) { result in
            switch result {
            case .success:
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequestError() {
        let expectation = XCTestExpectation(description: "Succes request in http://api.currencylayer.com/list")
        Network.request(method: .get, baseUrl: "http://api.currencylayerrrrrr.com/list", path: path, params: accessKeyParam) { result in
            switch result {
            case .success:
                XCTFail("This hostname does not exist")
                
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
