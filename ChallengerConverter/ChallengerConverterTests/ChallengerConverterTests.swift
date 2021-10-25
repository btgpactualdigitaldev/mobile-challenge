//
//  ChallengerConverterTests.swift
//  ChallengerConverterTests
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import XCTest
@testable import ChallengerConverter

class ChallengerConverterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvert() throws {
        let viewModel = BTGCurrencyConverterViewModel(repository: MockCurrencyRepository())
        viewModel.fromCurrency = "EUR"
        viewModel.toCurrency = "BRL"
        XCTAssertEqual(try? viewModel.calculate(value: 2), 13.179242, "Converte must be 13.179242")
    }
    
    func testConvertZero() throws {
        let viewModel = BTGCurrencyConverterViewModel(repository: MockCurrencyRepository())
        viewModel.fromCurrency = "EUR"
        viewModel.toCurrency = "BRL"
        XCTAssertEqual(try? viewModel.calculate(value: 0), 0, "Converte must be 0")
    }
}
