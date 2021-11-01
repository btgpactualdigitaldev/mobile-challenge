//
//  CurrenciesServiceTests.swift
//  BTG-CurrencyTests
//
//  Created by Ramon Almeida on 27/10/21.
//

import XCTest
import Combine
import BTG_Currency

class CurrenciesServiceTests: XCTestCase {
    var service: CurrenciesService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        service = Container.shared.resolve(CurrenciesService.self)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        service = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testListService_fetchList() {
        let expectation = XCTestExpectation(description: "ListService fetchList test")
        
        service.fetchList()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("FAILED\nerror:\(error.localizedDescription)")
                }
            } receiveValue: { list in
                XCTAssert(!list.isEmpty)
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
