//
//  CurrencyConverterViewModelTest.swift
//  BTGDasafioTests
//
//  Created by leonardo fernandes farias on 30/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import XCTest
@testable import BTGDasafio

class CurrencyConverterViewModelTest: XCTestCase {

    var viewModel: CurrencyConverterViewModel!
    
    override func setUp() {
       super.setUp()
        viewModel = CurrencyConverterViewModel(hasError: false, service: ServiceManager.sharedInstance)
    }

    override func tearDown() {
       super.tearDown()
        viewModel = nil
    }
    
    func testViewModelWithoutServiceCallBack() {
        XCTAssertNil(self.viewModel.fromCurrencyTitle)
        XCTAssertNil(self.viewModel.toCurrencyTitle)
        XCTAssertNil(self.viewModel.convertedCurrancy)
    }
    
    func testServiceCallBack() {
        let service = ServiceManager.sharedInstance
        viewModel = CurrencyConverterViewModel(hasError: false, service: service)
        var quotes: CurrentQuote?
        let currencyExpectation = expectation(description: "quote")
        viewModel.searchForCurrentQuote()
        service.currentQuoteRequest { (data, _) in
            quotes = data
            currencyExpectation.fulfill()
        }

        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNotNil(quotes)
        }
    }
    
    func testAlertTitles() {
        let title = "Não foi possivel completar a operação"
        XCTAssertEqual(viewModel.alertTitle, title)
        XCTAssertNotNil(viewModel.alertMessage)
    }
    
    func testViewControlerIdentifier() {
        let viewControllerIdentifier = "currencyModal"
        
        XCTAssertEqual(viewModel.vcIdentifier, viewControllerIdentifier)
    }

}
