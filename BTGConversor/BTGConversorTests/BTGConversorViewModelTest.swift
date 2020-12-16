//
//  BTGConversorViewModelTest.swift
//  BTGConversorTests
//
//  Created by Franclin Cabral on 12/15/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import XCTest
@testable import BTGConversor

class BTGConversorViewModelTest: XCTestCase {

    var viewModel: BTGConversorViewModel!
    var service: ConversorService!
    var executor: MockExecutor!
    
    enum ViewDelegationHit {
        case updateCurrencyFrom(String)
        case updateCurrencyTo(String)
        case clearTextField
        case updateConversion(String?)
        case updateConversionResult(String?)
        case enableTextField
    }
    
    var viewDelegationHit: ((ViewDelegationHit) -> Void)?
    
    override func setUp() {
        service = ConversorService()
        executor = MockExecutor()
        service.executor = executor
        viewModel = BTGConversorViewModel(service)
        viewModel.viewDelegate = self
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchQuota() {
        let expectation = self.expectation(description: "Wait to fetch quotas")
        executor.register(file: "liveQuota", target: ConversorApi.liveQuota, statusCode: 200)
        
        viewDelegationHit = { hit in
            switch hit {
            case .enableTextField:
                XCTAssertNotNil(self.viewModel.quotaData, "should not be nil")
                XCTAssertEqual(self.viewModel.quotaData!.source, "USD")
                expectation.fulfill()
            default:
                XCTFail("The test didn't get success")
                expectation.fulfill()
            }
        }
        
        viewModel.fetchQuota()
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}

extension BTGConversorViewModelTest: BTGConversorViewDelegate {
    func updateCurrencyFrom(_ viewModel: BTGConversorViewModel, title: String) {
        viewDelegationHit?(.updateCurrencyFrom(title))
    }
    
    func updateCurrencyTo(_ viewModel: BTGConversorViewModel, title: String) {
        viewDelegationHit?(.updateCurrencyTo(title))
    }
    
    func clearTextField(_ viewModel: BTGConversorViewModel) {
        viewDelegationHit?(.clearTextField)
    }
    
    func updateConversion(_ viewModel: BTGConversorViewModel, value: String?) {
        viewDelegationHit?(.updateConversion(value))
    }
    
    func updateConversionResult(_ viewModel: BTGConversorViewModel, value: String?) {
        viewDelegationHit?(.updateConversionResult(value))
    }
    
    func enableTextField(_ viewModel: BTGConversorViewModel) {
        viewDelegationHit?(.enableTextField)
    }
    
    
}
