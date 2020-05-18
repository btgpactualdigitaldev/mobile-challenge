//
//  CoinConvertViewModelTests.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import XCTest
@testable import BtgChallenge

class CoinConvertViewModelTests: XCTestCase {

    var viewModel: CoinConvertViewModel!
    var repository: CurrencyRepositorySpy!
    var viewController: ViewModelOutputSpy!
    
    override func setUp() {
        setup(withSuccessRepository: true)
    }
    
    func setup(withSuccessRepository isSuccess: Bool) {
        repository = CurrencyRepositorySpy(isSuccess: isSuccess)
        viewModel = CoinConvertViewModel(repository: repository)
        
        viewController = ViewModelOutputSpy()
        viewModel.viewController = viewController
    }

    // MARK: - Spy
    
    class ViewModelOutputSpy: CoinConvertViewModelOutput {
        var displayAlertMessageCalled = false
        var displayFromCoinNicknameCalled = false
        var displayToCoinNicknameCalled = false
        var displayConversionValueCalled = false
        
        var message = ""
        var coinNickname = ""
        var conversionValue = ""
        
        func displayAlertMessage(message: String) {
            self.message = message
            displayAlertMessageCalled = true
        }
        
        func displayFromCoinNickname(coinNickname: String) {
            self.coinNickname = coinNickname
            displayFromCoinNicknameCalled = true
        }
        
        func displayToCoinNickname(coinNickname: String) {
            self.coinNickname = coinNickname
            displayToCoinNicknameCalled = true
        }
        
        func displayConversionValue(conversionValue: String) {
            self.conversionValue = conversionValue
            displayConversionValueCalled = true
        }
    }
    
    // MARK: - Tests

    func testViewDidLoad() {
        // When
        viewModel.viewDidLoad()
        
        // Then
        
    }

    func testGetConversionQuote_SuccessResult() {
        // Given
        viewModel.fromCoinValue = "5.0"
        
        // When
        viewModel.getConversionQuote()
        
        // Then
        XCTAssertTrue(viewController.displayConversionValueCalled)
        XCTAssertEqual(viewController.conversionValue, "12.50")
    }
    
    func testGetConversionQuote_FailResult() {
        // Given
        setup(withSuccessRepository: false)
        viewModel.fromCoinValue = "5.0"
        
        // When
        viewModel.getConversionQuote()
        
        // Then
        XCTAssertTrue(viewController.displayAlertMessageCalled)
        XCTAssertEqual(viewController.message, Constants.Errors.apiDefaultMessage)
    }
    
    func testUpdateFromCoin() {
        // When
        viewModel.updateFromCoinValue(value: MockFactory.coinValue)
        
        // Then
        XCTAssertEqual(viewModel.fromCoinValue, MockFactory.coinValue)
    }
    
    func testUpdateSelectedCoinType() {
        // When
        viewModel.updateSelectedCoinType(type: MockFactory.coinType)
        
        // Then
        XCTAssertEqual(viewModel.selectedCoinType, MockFactory.coinType)
    }
    
    func testUpdateCoinNickname_WithToSelectedType() {
        // Given
        viewModel.selectedCoinType = .to
        
        // When
        viewModel.updateCoinNickname(nickname: MockFactory.dollarNickname)
        
        // Then
        XCTAssertTrue(viewController.displayToCoinNicknameCalled)
        XCTAssertEqual(viewController.coinNickname, MockFactory.dollarNickname)
        XCTAssertEqual(viewModel.toCoinNickname, MockFactory.dollarNickname)
    }
    
    func testUpdateCoinNickname_WithFromSelectedType() {
        // Given
        viewModel.selectedCoinType = .from
        
        // When
        viewModel.updateCoinNickname(nickname: MockFactory.dollarNickname)
        
        // Then
        XCTAssertTrue(viewController.displayFromCoinNicknameCalled)
        XCTAssertEqual(viewController.coinNickname, MockFactory.dollarNickname)
        XCTAssertEqual(viewModel.fromCoinNickname, MockFactory.dollarNickname)
    }

}
