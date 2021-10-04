//
//  CurrencyListViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Eduardo Lopes on 03/10/21.
//

import XCTest
@testable import CurrencyConverter

class CurrencyListViewModelTests: XCTestCase {
    let modelMock = Currency(success: true,
                         currencies: ["BRT" : "Brazilian Test", "USD" : "American Dolar"])
    var didReloadDataCalls: Int = 0
    var failedToGetCurrencyListCalls: Int = 0

    lazy var sut: CurrencyListViewModel = {
        let sut = CurrencyListViewModel(delegate: self)
        return sut
    }()
    
    func testLoadData_ItShouldReturnProperFilteredData() {
        sut.loadData(with: modelMock)
        XCTAssertTrue(sut.models.contains("USD: American Dolar"))
        XCTAssertTrue(sut.models.contains("BRT: Brazilian Test"))
    }
    
    func testLoadData_ItShouldCallDelegate() {
        sut.loadData(with: modelMock)
        XCTAssertEqual(didReloadDataCalls, 1)
    }
    
    func testUpdateSearchResults_ItShouldFailForNoData(){
        let searchController = UISearchController()
        sut.updateSearchResults(for: searchController)
        XCTAssertEqual(sut.models, [])
        XCTAssertEqual(didReloadDataCalls, 1)
        XCTAssertEqual(failedToGetCurrencyListCalls, 1)
    }
    
    func testGetNumberOfRows_ItShouldReturn0ForNoData() {
        let rows = sut.getNumberOfRows()
        XCTAssertEqual(rows, 0)
    }

}

extension CurrencyListViewModelTests: CurrencyListViewModelDelegate {
    
    func didReloadData() {
        didReloadDataCalls += 1
    }
    
    func failedToGetCurrencyList() {
        failedToGetCurrencyListCalls += 1
    }
    
}
