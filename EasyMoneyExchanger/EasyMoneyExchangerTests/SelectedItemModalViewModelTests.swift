//
//  SelectedItemModalViewModelTests.swift
//  EasyMoneyExchangerTests
//
//  Created by Leon on 14/12/20.
//

import XCTest
@testable import EasyMoneyExchanger

class SelectedItemModalViewModelTests: XCTestCase {

    private var viewModel: SelectItemModalViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SelectItemModalViewModel(coreData: CoreDataManager())
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testFilterBarList() {
        let list = [SupportedList(currencyCode: "BRL", currencyName: "Brazilian Real"), SupportedList(currencyCode: "USD", currencyName: "United States Dollar")]
        let result = viewModel.filterSearchbarList(list: list, searchText: "BRL")
        XCTAssert(result[0].currencyName == "Brazilian Real", "Test Failed")
    }
}
