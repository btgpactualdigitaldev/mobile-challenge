//
//  CurenciesViewModelTests.swift
//  mobile-challengeTests
//
//  Created by Murilo Teixeira on 26/09/20.
//

import XCTest
@testable import mobile_challenge

class CurenciesViewModelTests: XCTestCase {
    
    var viewModel: CurrencyListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CurrencyListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testViewModelIsNotNil() {
        XCTAssertNotNil(viewModel)
    }
    
    func testCurrenciesIsNotNil() {
        XCTAssertNotNil(viewModel.currencies)
    }
    
    func testFetchCurrencies() {
        let networkManage = NetworkManage()
        let service: ConverterService = .currencyList
        
        networkManage.request(service: service, resposeType: CurrencyListResponse.self) { result in
            switch result {
            case .success(let currencyResponse):
                XCTAssertTrue(currencyResponse.success)
            case .failure:
                print("error to request")
            }
        }
        
    }

}
