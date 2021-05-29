//
//  CurrencyListViewModel.swift
//  mobile-challengeTests
//
//  Created by Caio Azevedo on 28/11/20.
//

import XCTest
@testable import mobile_challenge

class CurrencyListViewModelTests: XCTestCase {

    var sut: CurrencyListViewModel!

    override func setUp() {
        sut = CurrencyListViewModel()
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_sortArray_byCode() {
        let currenciesQuotation = [CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "BRL", currency: "Brasilian Real", quotation: 5.34), CurrencyQuotation(code: "BTN", currency: "Bhutanese Ngultrum", quotation: 5.34)]
        
        let result = sut.sortArray(by: .code, currenciesQuotation: currenciesQuotation)
        
        
        XCTAssertEqual(result.first?.values.first?.first?.code, "BRL")
        XCTAssertEqual(result.first?.values.first?[1].code, "BTN")
        XCTAssertEqual(result[1].values.first?.first?.code, "EUR")
    }
    
    func test_sortArray_byName() {
        let currenciesQuotation = [CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "BRL", currency: "Brasilian Real", quotation: 5.34), CurrencyQuotation(code: "BTN", currency: "Bhutanese Ngultrum", quotation: 5.34)]
        
        let result = sut.sortArray(by: .name, currenciesQuotation: currenciesQuotation)
        
        
        XCTAssertEqual(result.first?.values.first?.first?.code, "BTN")
        XCTAssertEqual(result.first?.values.first?[1].code, "BRL")
        XCTAssertEqual(result[1].values.first?.first?.code, "EUR")
    }
    
    func test_groupSortedArray() {
        let currenciesQuotation = [CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "EUR", currency: "Euro", quotation: 0.84), CurrencyQuotation(code: "BRL", currency: "Brasilian Real", quotation: 5.34), CurrencyQuotation(code: "BTN", currency: "Bhutanese Ngultrum", quotation: 5.34)]
        
        let result = sut.groupSortedArray(type: .code, currencyList: currenciesQuotation)
        
        
        XCTAssertEqual(result[0].keys.first, "B")
        XCTAssertEqual(result.first?.values.first?.first?.code, "BRL")
    }
    
    func test_filterCurrenciesDict() {
        let searchName = "Eur"
        let currency = "Euro"
        let currenciesQuotation = [CurrencyQuotation(code: "EUR", currency: currency, quotation: 0.84), CurrencyQuotation(code: "BRL", currency: "Brasilian Real", quotation: 5.34), CurrencyQuotation(code: "BTN", currency: "Bhutanese Ngultrum", quotation: 5.34)]
        
        let currencyDict = sut.sortArray(by: .name, currenciesQuotation: currenciesQuotation)
        
        let result = sut.filterCurrenciesDict(searchString: searchName.lowercased(), currenciesDict: currencyDict)
        
        XCTAssertEqual(result[0].currency, currency)
        
    }

}
