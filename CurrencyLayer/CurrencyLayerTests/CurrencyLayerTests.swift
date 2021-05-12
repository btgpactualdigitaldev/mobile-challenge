//
//  CurrencyLayerTests.swift
//  CurrencyLayerTests
//
//  Created by Filipe Cruz on 14/12/20.
//
@testable import CurrencyLayer
import XCTest
import Foundation
import Combine

class CurrencyLayerViewModelTests: XCTestCase {
    var currencyLayerViewModel: CurrencyConversionViewModel!
    var currencyFetcherMock: CurrencyFetcherMock!
    var cancellables: Set<AnyCancellable>!
  
    override func setUp() {
      super.setUp()
      currencyFetcherMock = CurrencyFetcherMock()
      currencyLayerViewModel = CurrencyConversionViewModel(fetcher: currencyFetcherMock)
    }

    override func tearDownWithError() throws {
      currencyLayerViewModel = nil
      currencyFetcherMock = nil
      super.tearDown()
    }

    func testViewModelFlow() throws {
      currencyLayerViewModel.fetchCurrecyListAndCurrencies()
      
      XCTAssertNotNil(currencyLayerViewModel.state.currencies)

    }

}

