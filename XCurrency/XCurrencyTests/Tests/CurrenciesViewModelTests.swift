//
//  CurrenciesViewModelTests.swift
//  XCurrencyTests
//
//  Created by Vinicius Nadin on 01/04/21.
//

import XCTest
@testable import XCurrency

class CurrenciesViewModelTests: XCTestCase {

    // MARK: - Attributes
    private var viewModel: CurrencysViewModel!
    private var network: Networking!
    private var repository: CurrencyRepositoryMock!
    private var updateCurrenciesCount: Int = 0

    // MARK: - Overrides
    override func tearDown() {
        self.network = nil
        self.repository = nil
        self.viewModel = nil
        super.tearDown()
    }

    // MARK: - Setup
    func setup<V: Encodable>(data: DataMock<V>) {
        self.network = NetworkMock(data: data)
        self.repository = CurrencyRepositoryMock(network: self.network)
        self.viewModel = CurrencysViewModel(currencyRepository: self.repository)
    }

    // MARK: - Tests
    func test_getCurrenciesList_success() {
        let data: DataMock = ["currencies": ["BRL": "Brazilian Real"]]
        self.setup(data: data)
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.currenciesCount(), 1)
    }

    func test_getCurrenciesList_error() {
        let data: DataMock = ["1": ["2": "3"]]
        self.setup(data: data)
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertFalse(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.errorMessage, "ERROR")
        XCTAssertEqual(self.viewModel.currenciesCount(), 0)
    }

    func test_getCurrency_onIndex_success() {
        let data: DataMock = ["currencies": ["BRL": "Brazilian Real", "USD": "United States Dollar"]]
        self.setup(data: data)
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.currenciesCount(), 2)
        XCTAssertNotNil(self.viewModel.getCurrency(position: 0))
        XCTAssertEqual(self.viewModel.getCurrency(position: 0)!.code, "BRL")
    }

    func test_orderCurrenciesBy_name() {
        let data: DataMock = ["currencies": ["USD": "United States Dollar", "BRL": "Brazilian Real"]]
        self.setup(data: data)
        self.viewModel.orderCurrenciesBy(.name)
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.currenciesCount(), 2)
        XCTAssertNotNil(self.viewModel.getCurrency(position: 0))
        XCTAssertEqual(self.viewModel.getCurrency(position: 0)!.name, "Brazilian Real")
    }

    func test_orderCurrenciesBy_code() {
        let data: DataMock = ["currencies": ["USD": "United States Dollar", "BRL": "Brazilian Real"]]
        self.setup(data: data)
        self.viewModel.orderCurrenciesBy(.code)
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.currenciesCount(), 2)
        XCTAssertNotNil(self.viewModel.getCurrency(position: 0))
        XCTAssertEqual(self.viewModel.getCurrency(position: 0)!.code, "BRL")
    }

    func test_filterCurrencies_by_text() {
        let data: DataMock = ["currencies": ["USD": "United States Dollar", "BRL": "Brazilian Real"]]
        self.setup(data: data)
        self.viewModel.filterCurrenciesBy(text: "BRL")
        XCTAssertEqual(self.repository.getCurrencyListCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.currenciesCount(), 1)
        XCTAssertNotNil(self.viewModel.getCurrency(position: 0))
        XCTAssertEqual(self.viewModel.getCurrency(position: 0)!.code, "BRL")
    }
}
