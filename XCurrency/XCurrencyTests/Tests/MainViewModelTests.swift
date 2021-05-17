//
//  MainViewModelTests.swift
//  XCurrencyTests
//
//  Created by Vinicius Nadin on 01/04/21.
//

import XCTest
@testable import XCurrency

class MainViewModelTests: XCTestCase {

    // MARK: - Attributes
    private var viewModel: MainViewModel!
    private var network: Networking!
    private var repository: CurrencyRepositoryMock!

    // MARK: - Overrides
    override func tearDown() {
        self.viewModel = nil
        self.network = nil
        self.repository = nil
        super.tearDown()
    }

    // MARK: - Setup
    func setup<V: Encodable>(data: DataMock<V>) {
        self.network = NetworkMock(data: data)
        self.repository = CurrencyRepositoryMock(network: self.network)
        self.viewModel = MainViewModel(currencyRepository: self.repository)
    }

    // MARK: - Tests
    func test_getCurrenciesRates_success() {
        let data: DataMock = ["quotes": ["USDAED": 3.67315, "USDAFN": 60.790001]]
        self.setup(data: data)
        XCTAssertEqual(self.repository.getCurrenciesRateCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
    }

    func test_getCurrenciesRates_error() {
        let data: DataMock = ["1": ["2": "3", "4": "5"]]
        self.setup(data: data)
        XCTAssertEqual(self.repository.getCurrenciesRateCount, 1)
        XCTAssertFalse(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.errorMessage, "ERROR")
    }

    func test_convertValueToCurrency_without_select_firstCurrency_error() {
        let secondCurrency: Currency = Currency(name: "United States Dollar", code: "USD")
        let data: DataMock = ["quotes": ["USDAED": 3.67315, "USDAFN": 60.790001]]
        self.setup(data: data)
        self.viewModel.secondCurrency = secondCurrency
        self.viewModel.convertValueToCurrency(valueToConvert: 100)
        XCTAssertEqual(self.repository.getCurrenciesRateCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.convertedValue, "0.0")
    }

    func test_convertValueToCurrency_without_select_SecondCurrency_error() {
        let firstCurrency: Currency = Currency(name: "United States Dollar", code: "USD")
        let data: DataMock = ["quotes": ["USDAED": 3.67315, "USDAFN": 60.790001]]
        self.setup(data: data)
        self.viewModel.firstCurrency = firstCurrency
        self.viewModel.convertValueToCurrency(valueToConvert: 100)
        XCTAssertEqual(self.repository.getCurrenciesRateCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.convertedValue, "0.0")
    }

    func test_convertValueToCurrency_success() {
        let firstCurrency: Currency = Currency(name: "United States Dollar", code: "USD")
        let secondCurrency: Currency = Currency(name: "Brazilian Real", code: "BRL")
        let data: DataMock = ["quotes": ["USDBRL": 5.633498, "USDUSD": 1]]
        self.setup(data: data)
        self.viewModel.firstCurrency = firstCurrency
        self.viewModel.secondCurrency = secondCurrency
        self.viewModel.convertValueToCurrency(valueToConvert: 1.0)
        XCTAssertEqual(self.repository.getCurrenciesRateCount, 1)
        XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
        XCTAssertEqual(self.viewModel.convertedValue, "5.63")
    }
}
