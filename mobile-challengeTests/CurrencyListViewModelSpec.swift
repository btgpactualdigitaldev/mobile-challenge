//
//  CurrencyListViewModelSpec.swift
//  mobile-challengeTests
//
//  Created by Brunno Andrade on 05/10/20.
//

import XCTest
@testable import mobile_challenge

class CurrencyListViewModelSpec: XCTestCase {
    
    var currencyListVM: CurrencyListViewModel!
    var currencyListMock: CurrencyList!

    override func setUpWithError() throws {
        currencyListVM = CurrencyListViewModel(type: .origin)
    
        currencyListMock = CurrencyList(success: true, error: nil, currencies: ["AED":"United Arab Emirates Dirham", "AFN": "Afghan Afghani"])
        
        currencyListVM.setCurrenciesArray(currencyList: currencyListMock)
    }

    override func tearDownWithError() throws {
        currencyListVM = nil
    }

    
    func testListCurrencies() {

        XCTAssertEqual(2, currencyListVM.currencies.count)
        XCTAssertEqual(2, currencyListVM.currenciesFilter.count)
    }
    
    func testTypeConverterChange() {
        let vm = CurrencyListViewModel(type: .destiny)
        
        XCTAssertEqual(vm.typeConverter, .destiny)
    }
    
    func testFilterCurrencies() {
        
        currencyListVM.filterCurrencies(search: "AFN")
        
        XCTAssertEqual(2, currencyListVM.currencies.count)
        XCTAssertEqual(1, currencyListVM.currenciesFilter.count)
    }
    
    func testFilterCurrenciesNotValue() {
        
        currencyListVM.filterCurrencies(search: "")
        
        XCTAssertEqual(2, currencyListVM.currencies.count)
        XCTAssertEqual(2, currencyListVM.currenciesFilter.count)
    }
    
    func testOrderbyCode() {
        
        currencyListVM.orderBy(order: .code)
        
        XCTAssertEqual("AED", currencyListVM.currencies[0].code)
        XCTAssertEqual("AFN", currencyListVM.currenciesFilter[1].code)
    }
    
    func testOrderbyDescription() {
        
        currencyListVM.orderBy(order: .description)
        
        XCTAssertEqual("Afghan Afghani", currencyListVM.currencies[0].description)
        XCTAssertEqual("United Arab Emirates Dirham", currencyListVM.currenciesFilter[1].description)
    }
    
    
}
