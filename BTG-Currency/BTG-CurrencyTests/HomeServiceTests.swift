//
//  HomeServiceTests.swift
//  BTG-CurrencyTests
//
//  Created by Ramon Almeida on 27/10/21.
//

import XCTest
import Combine
import BTG_Currency

class HomeServiceTests: XCTestCase {
    var service: HomeService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        service = Container.shared.resolve(HomeService.self)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        service = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testListService_fetchList() {
        let expectation = XCTestExpectation(description: "HomeService fetchLive test")
        
        service.fetchLive(fromCurrency: Currency(value: 10.00, code: "BRL"), toCurrencyCode: "MWK")
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("FAILED\nerror:\(error.localizedDescription)")
                }
            } receiveValue: { currency in
                XCTAssert(currency != 0.0)
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
