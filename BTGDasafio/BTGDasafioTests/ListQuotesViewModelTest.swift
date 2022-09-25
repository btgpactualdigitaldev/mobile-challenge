//
//  ListQuotesViewModelTest.swift
//  BTGDasafioTests
//
//  Created by leonardo fernandes farias on 30/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import XCTest
@testable import BTGDasafio

class ListQuotesViewModelTest: XCTestCase {
    var currency: [Currency]!
    var viewModel: ListQuotesViewModel!
    
    func setUpCurrency() {
        let values: [Currency] = [
            Currency(value: 1, currency: "USD"),
            Currency(value: 5.391, currency: "BRL")
        ]
        currency = values
        viewModel = ListQuotesViewModel(currencyList: currency)
    }
    
    override func setUp() {
        super.setUp()
        self.setUpCurrency()
    }
    
    override func tearDown() {
        super.tearDown()
        currency = nil
        viewModel = nil
    }
    
    func testNumberOfRowsWithArray() {
        XCTAssertEqual(viewModel.numberOfRows, 2)
    }
    
    func testTitleForCellAtIndex() {
        XCTAssertEqual(viewModel.cellTitle(at: 0), "USD")
        XCTAssertEqual(viewModel.cellTitle(at: 1), "BRL")
        XCTAssertNil(viewModel.cellTitle(at: 2))
    }
    
    func testCellIdentifier() {
        let cellIdentifier = "quoteCell"
        XCTAssertEqual(viewModel.cellIdentifier, cellIdentifier)
    }
    
    func testViewModelWithEmptyArray() {
        viewModel = ListQuotesViewModel(currencyList: [])
        XCTAssertEqual(viewModel.numberOfRows, 0)
        XCTAssertNil(viewModel.cellTitle(at: 0))
        XCTAssertNil(viewModel.currency(at: 0))
    }

}
