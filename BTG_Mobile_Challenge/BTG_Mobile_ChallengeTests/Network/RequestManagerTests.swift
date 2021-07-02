//
//  RequestManagerTests.swift
//  BTG_Mobile_ChallengeTests
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import XCTest
@testable import BTG_Mobile_Challenge

class RequestManagerTests: XCTestCase {
    
    var service: ServiceMock!
    var sut: RequestManager!
    
    override func setUpWithError() throws {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        service = ServiceMock(bundle: bundle)
        sut = RequestManager(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    func testLiveCurrencyBehavior() {        
        let expectation = XCTestExpectation()
        
        let url = CurrencyAPIEndpoint.live.url
        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        let stubJSONData = try! Data(contentsOf: stubJSONURL!) 
        let stubJSON = try! JSONDecoder().decode(CurrencyReponseFromLive.self, from: stubJSONData)
        
        service.json = stubJSONURL
        
        self.sut?.getRequest(url: url!, decodableType: CurrencyReponseFromLive.self) { (response) in
            switch response {
            case .success(let result):
                XCTAssertTrue(result.success)
                XCTAssertFalse(result.quotes.isEmpty)
                XCTAssertEqual(stubJSON, result)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testListCurrencyBehavior() {
        let expectation = XCTestExpectation()
        
        let url = CurrencyAPIEndpoint.list.url
        let stubJSONURL = service.bundle.url(forResource: "list-response", withExtension: "json")
        let stubJSONData = try! Data(contentsOf: stubJSONURL!) 
        let stubJSON = try! JSONDecoder().decode(CurrencyResponseFromList.self, from: stubJSONData)
        
        service.json = stubJSONURL
        
        self.sut?.getRequest(url: url!, decodableType: CurrencyResponseFromList.self) { [](response) in
            switch response {
            case .success(let result):
                XCTAssertEqual(stubJSON.currencies.count, result.currencies.count)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}
