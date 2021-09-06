//
//  CurrencyListViewModelTests.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

import XCTest
@testable import Curriencies

final class CurrencyListViewModelTests: XCTestCase {
    
    lazy var sut: CurrencyListViewModel = {
        let sut = CurrencyListViewModel(currencies: currenciesDummy,
                                        currencyType: .destination)
        sut.delegate = delegateDummy
        
        return sut
    }()
    
    let delegateDummy = DelegateDummy()
    let currenciesDummy = [
        CurrencyEntity(code: "USD", name: "American Dolar", value: 1),
        CurrencyEntity(code: "EUR", name: "Euro", value: 2),
        CurrencyEntity(code: "BRL", name: "Brazilian Real", value: 5),
    ]
    
    func testNumberOfSections_WhenCreateTableView_ShouldReturnOneSection() {
        let sectionsCount = sut.numberOfSections()
        
        XCTAssertEqual(sectionsCount, 1)
    }
    
    func testNumberOfRows_WhenHasCurrencies_ShouldReturnCountOfCurrencies() {
        let rowsCount = sut.numberOfRows()
        
        XCTAssertEqual(rowsCount, 3)
    }
    
    func testCellForItemAt_WhenRowIsHigherThanCurrenciesCount_ShouldReturnDefaultCellModel() {
        let cell = sut.cellForItemAt(9999)
        
        XCTAssertEqual(cell.code, "USD")
        XCTAssertEqual(cell.name, "Dólar")
    }
    
    func testCellForItemAt_WhenHasCurrencyForIndex_ShouldReturnModel() {
        let cell = sut.cellForItemAt(1)
        
        XCTAssertEqual(cell.code, "EUR")
        XCTAssertEqual(cell.name, "Euro")
    }
    
    func testDidSelectCellAt_WhenHasCurrencyForIndex_ShouldCallDelegate() {
        sut.didSelectCellAt(1)
        
        XCTAssertEqual(delegateDummy.callUpdateNewCurrency, 1)
        XCTAssertEqual(delegateDummy.titleReceive, "EUR")
        XCTAssertEqual(delegateDummy.typeReceive, .destination)
    }
    
    func testHeightForRowAt_WhenCreateTableView_ShouldReturnHeight() {
        let height = sut.heightForRowAt()
        
        XCTAssertEqual(height, 50)
    }
    
    func testSearchBarCancelButtonPressed_WhenCancelButtonPressed_ShouldUpdateArrayOfCurrencies() {
        sut.searchBarCancelButtonPressed()
        
        XCTAssertEqual(sut.currenciesPresented.count, sut.currencies.count)
    }
    
    func testSearch_WhenReceiveNewText_ShouldFilterArray() {
        sut.search(text: "U")
        
        XCTAssertEqual(sut.currenciesPresented[0].code, "USD")
        XCTAssertEqual(sut.currenciesPresented[1].code, "EUR")
        XCTAssertEqual(sut.currenciesPresented.count, 2)
    }
    
    func testSearch_WhenReceiveEmptyText_ShouldPresentFullArray() {
        sut.search(text: "")
        
        XCTAssertEqual(sut.currenciesPresented.count, 3)
    }
    
    func testSortCurrencies_WhenSortTypeIsCode_ShouldPresentCurrenciesSorted() {
        sut.sortCurrencies(sortType: .code)
        
        XCTAssertEqual(sut.currenciesPresented[0].code, "BRL")
        XCTAssertEqual(sut.currenciesPresented[1].code, "EUR")
        XCTAssertEqual(sut.currenciesPresented[2].code, "USD")
    }
    
    func testSortCurrencies_WhenSortTypeIsName_ShouldPresentCurrenciesSorted() {
        sut.sortCurrencies(sortType: .name)
        
        XCTAssertEqual(sut.currenciesPresented[0].code, "USD")
        XCTAssertEqual(sut.currenciesPresented[1].code, "BRL")
        XCTAssertEqual(sut.currenciesPresented[2].code, "EUR")
    }
}
