//
//  SupportedCurrenciesViewModelTests.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 04/10/20.
//
// swiftlint:disable all

import XCTest
@testable import btg_mobile_challenge

final class SupportedCurrenciesViewModelTests: XCTestCase {
    var sut: SupportedCurrenciesViewModel!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let jsonURL = bundle.url(forResource: "list-response", withExtension: "json")
        let jsonData = try! Data(contentsOf: jsonURL!)
        let listResponse = try! JSONDecoder().decode(ListCurrencyResponse.self, from: jsonData)

        sut = SupportedCurrenciesViewModel(currencies: listResponse)
    }

    func testNumberOfSections() {
        XCTAssertEqual(sut.numberOfSections, 1)
    }

    func testNumberOfRowsInSection() {
        XCTAssertEqual(sut.numberOfRows(in: 0), 168)
    }

    func testCurrencyCodeAt() {
        XCTAssertEqual(sut.currencyCodeAt(index: IndexPath(row: 0, section: 0)), "AED")
        XCTAssertEqual(sut.currencyCodeAt(index: IndexPath(row: 19, section: 0)), "BRL")
        XCTAssertEqual(sut.currencyCodeAt(index: IndexPath(row: 149, section: 0)), "USD")
    }

    func testCurrencyNameAt() {
        XCTAssertEqual(sut.currencyNameAt(index: IndexPath(row: 0, section: 0)), "United Arab Emirates Dirham")
        XCTAssertEqual(sut.currencyNameAt(index: IndexPath(row: 19, section: 0)), "Brazilian Real")
        XCTAssertEqual(sut.currencyNameAt(index: IndexPath(row: 149, section: 0)), "United States Dollar")
    }


    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
