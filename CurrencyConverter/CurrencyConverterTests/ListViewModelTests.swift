//
//  ListViewModelSpec.swift
//  CurrencyConverterTests
//
//  Created by Breno Aquino on 01/11/20.
//

import XCTest
@testable import CurrencyConverter

class ListViewModelSpec: XCTestCase {

    let currency1 = try! Currecy(code: "BRL", name: "Brazilian Real")
    let currency2 = try! Currecy(code: "EUR", name: "Euro")
    let currency3 = try! Currecy(code: "ZAS", name: "Zaseu")
    let currency4 = try! Currecy(code: "ASD", name: "mklsd")
    lazy var currencies = [currency1, currency2, currency3, currency4]
    
    func testFullCode() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "BRL")
        XCTAssert(listViewModel.currenciesDisplayed.count == 1)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "BRL")
    }
    
    func testFullName() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "mklsd")
        XCTAssert(listViewModel.currenciesDisplayed.count == 1)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "ASD")
    }
    
    func testCodeAndNameBind() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "EU")
        XCTAssert(listViewModel.currenciesDisplayed.count == 2)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "EUR")
        XCTAssert(listViewModel.currenciesDisplayed[1].code == "ZAS")
    }
    
    func testPartialName() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "bra")
        XCTAssert(listViewModel.currenciesDisplayed.count == 1)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "BRL")
    }
    
    func testPartialCode() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "b")
        XCTAssert(listViewModel.currenciesDisplayed.count == 1)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "BRL")
    }
    
    func testSecondSearch() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "BRL")
        listViewModel.serach(for: "EUR")
        XCTAssert(listViewModel.currenciesDisplayed.count == 1)
        XCTAssert(listViewModel.currenciesDisplayed[0].code == "EUR")
    }
    
    func testEmptySearch() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "")
        XCTAssert(listViewModel.currenciesDisplayed.count == 4)
    }
    
    func testEmptySecondSearch() throws {
        let listViewModel = ListViewModel(type: .origin)
        listViewModel.currencies = currencies
        listViewModel.serach(for: "BRL")
        listViewModel.serach(for: "")
        XCTAssert(listViewModel.currenciesDisplayed.count == 4)
    }
}
