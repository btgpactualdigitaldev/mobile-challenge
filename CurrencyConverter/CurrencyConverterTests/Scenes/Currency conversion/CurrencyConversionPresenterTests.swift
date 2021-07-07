//
//  CurrencyConversionPresenterTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class CurrencyConversionPresenterTests: XCTestCase {
    var sut: CurrencyConversionPresenter!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyConversionPresenter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    final class ViewControllerSpy: CurrencyConversionDisplayLogic {
        var loadSupportedCurrenciesCalled = false
        var displayErrorMessageCalled = false
        var displayConvertedValueCalled = false
        var exchangeRatesLoadedCalled = false
        var supportedCurrenciesLoadedCalled = false
        
        var supportedCurrenciesViewModel: CurrencyConversion.LoadSupportedCurrencies.ViewModel!
        var formattedCurrencyViewModel: CurrencyConversion.FormatTextField.ViewModel!
        
        func loadSupportedCurrencies(viewModel: CurrencyConversion.LoadSupportedCurrencies.ViewModel) {
            loadSupportedCurrenciesCalled = true
            supportedCurrenciesViewModel = viewModel
        }
        
        func displayErrorMessage(_ message: String) {
            displayErrorMessageCalled = true
        }
        
        func exchangeRatesLoaded() {
            exchangeRatesLoadedCalled = true
        }
        
        func supportedCurrenciesLoaded() {
            supportedCurrenciesLoadedCalled = true
        }
        
        func displayFormattedValue(viewModel: CurrencyConversion.FormatTextField.ViewModel) {
            displayConvertedValueCalled = true
            formattedCurrencyViewModel = viewModel
        }
    }
    
    func testPresenter_whenReceiveSuccessFalseFromSupportedCurrenciesStatus_isCallingDisplayErrorMessageFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let response = CurrencyConversion.LoadSupportedCurrencies.Response(success: false)
        
        sut.loadSupportedCurrencyStatus(response: response)
        
        XCTAssertTrue(viewControllerSpy.displayErrorMessageCalled)
    }
    
    func testPresenter_whenRunsExchangeRatesFailed_isCallingDisplayErrorMessageFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        
        sut.getExchangeRatesStatus(response: CurrencyConversion.GetExchangeRates.Response(success: false))
        
        XCTAssertTrue(viewControllerSpy.displayErrorMessageCalled)
    }
    
    func testPresenter_whenRunsExchangeRatesWithSuccess_isCallingExchangeRatesLoadedFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        
        sut.getExchangeRatesStatus(response: CurrencyConversion.GetExchangeRates.Response(success: true))
        
        XCTAssertTrue(viewControllerSpy.exchangeRatesLoadedCalled)
    }
    
    func testPresenter_whenRunsCurrencyConversion_isCallingDisplayConvertedValueFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        
        sut.formatNumericValueToText(response: CurrencyConversion.FormatTextField.Response(number: 10.0, currencyInitials: "BRL", textField: .result))
        
        XCTAssertTrue(viewControllerSpy.displayConvertedValueCalled)
    }
    
    func testPresenter_whenRunsCurrencyConversion_isSendingFormattedValueToViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let expectedValue = "R$ 1.000,00"
        
        sut.formatNumericValueToText(response: CurrencyConversion.FormatTextField.Response(number: 1000.0, currencyInitials: "BRL", textField: .result))
        
        XCTAssertEqual(expectedValue, viewControllerSpy.formattedCurrencyViewModel.formattedText)
    }
}
