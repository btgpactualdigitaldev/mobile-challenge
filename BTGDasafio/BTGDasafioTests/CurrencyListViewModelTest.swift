//
//  CurrencyListViewModelTest.swift
//  BTGDasafioTests
//
//  Created by leonardo fernandes farias on 30/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import XCTest
@testable import BTGDasafio

class CurrencyListViewModelTest: XCTestCase {
    var viewModel: CurrencyListViewModel!
    
    override func setUp() {
       super.setUp()
        viewModel = CurrencyListViewModel(hasError: false, isLoading: true, service: ServiceManager.sharedInstance)
    }

    override func tearDown() {
       super.tearDown()
       viewModel = nil
    }
    
    func testViewModelWithoutServiceCallBack() {
        XCTAssertEqual(self.viewModel.numberOfRows ?? 0, 0)
        XCTAssertFalse(self.viewModel.isSearchBarEnable)
        XCTAssertNil(self.viewModel.cellTitle(at: 0))
        XCTAssertNil(self.viewModel.cellMessage(at: 0))
    }
    
    func testServiceCallBack() {
        let service = ServiceManager.sharedInstance
        var response: ExchangeRate?
        viewModel = CurrencyListViewModel(hasError: false, isLoading: true, service: service)
        XCTAssertFalse(viewModel.isSearchBarEnable)

        let currencyExpectation = expectation(description: "currency")
        viewModel.searchForCurrency()
        service.exchangeRateListRequest { (data, _) in
            response = data
            currencyExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNotNil(response)
        }
    }
    
    func testAlertTitles() {
        let title = "Não foi possivel completar a operação"
        XCTAssertEqual(viewModel.alertTitle, title)
        XCTAssertNotNil(viewModel.alertMessage)
    }
    
    func testCellIdentifier() {
        let cellIdentifier = "currencyCell"
        XCTAssertEqual(viewModel.cellIdentifier, cellIdentifier)
    }

}
