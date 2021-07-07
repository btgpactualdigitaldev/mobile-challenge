//
//  CurrencyConversionInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class CurrencyConversionInteractorTests: XCTestCase {
    var sut: CurrencyConversionInteractor!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func initSutWithError() {
        sut = CurrencyConversionInteractor(supportedCurrenciesWorker: NetworkSupportedCurrenciesWorkerMock(returnError: NetworkSupportedCurrenciesWorkerError.requestError),
                                           exchangeRatesWorker: NetworkExchangeRatesWorkerMock(returnError: NetworkExchangeRatesWorkerError.requestError),
                                           currencyConversionWorker: CurrencyConversionWorkerMock(returnValue: -1))
    }
    
    private func initSut() {
        sut = CurrencyConversionInteractor(supportedCurrenciesWorker: NetworkSupportedCurrenciesWorkerMock(),
                                           exchangeRatesWorker: NetworkExchangeRatesWorkerMock(),
                                           currencyConversionWorker: CurrencyConversionWorkerMock(returnValue: 10.0))
    }
    
    final class CurrencyConversionPresenterSpy: CurrencyConversionPresentationLogic {
        var formatCurrencyListCalled = false
        var getExchangeStatusCalled = false
        var formatCurrencyListResponse: CurrencyConversion.LoadSupportedCurrencies.Response!
        var formatConvertedCurrencyForViewCalled = false
        var formatConvertedCurrencyResponse: CurrencyConversion.FormatTextField.Response!
        
        
        func loadSupportedCurrencyStatus(response: CurrencyConversion.LoadSupportedCurrencies.Response) {
            formatCurrencyListCalled = true
            formatCurrencyListResponse = response
        }
        
        func getExchangeRatesStatus(response: CurrencyConversion.GetExchangeRates.Response) {
            getExchangeStatusCalled = true
        }

        func formatNumericValueToText(response: CurrencyConversion.FormatTextField.Response) {
            formatConvertedCurrencyForViewCalled = true
            formatConvertedCurrencyResponse = response
        }
    }
    
    func testInteractor_afterRunGetSupportedCurrencies_isCallingFormatCurrencyListFromPresenter() {
        initSut()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getSupportedCurrencies()
        
        XCTAssertTrue(presenterSpy.formatCurrencyListCalled)
    }
    
    func testInteractor_afterRunGetExchangeRates_isSettingTheUsdCurrencyQuotes() {
        initSut()
        
        sut.getExchangeRates()
        
        XCTAssertEqual(Seeds.APISeeds.exchangeRates.getUSDCurrencyQuotes(), sut.usdCurrencyQuotes)
    }
    
    func testInteractor_whenGetSupportedCurrenciesReturnError_isSendingSuccessFalseToPresenter() {
        initSutWithError()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getSupportedCurrencies()
        
        XCTAssertFalse(presenterSpy.formatCurrencyListResponse.success)
    }
    
    func testInteractor_whenGetExchangeRatesRuns_isCallingGetExchangeRatesStatusFromPresenter() {
        initSutWithError()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getExchangeRates()
        
        XCTAssertTrue(presenterSpy.getExchangeStatusCalled)
    }
    
    func testInteractor_afterRunGetSupportedCurrencies_isSendingSuccessToPresenter() {
        initSut()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getSupportedCurrencies()
        
        XCTAssertTrue(presenterSpy.formatCurrencyListResponse.success)
    }
    
    func testInteractor_afterRunConvertCurrency_isCallingFormatConvertedCurrencyFromPresenter() {
        initSut()
        sut.usdCurrencyQuotes = Seeds.APISeeds.exchangeRates.getUSDCurrencyQuotes()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.convertCurrency(request: CurrencyConversion.ConvertValue.Request(sourceInitials: "USD", sourceValue: "US$1,00", resultInitials: "BRL", textField: .result))
        
        XCTAssertTrue(presenterSpy.formatConvertedCurrencyForViewCalled)
    }
    
    func testInteractor_afterRunConvertCurrency_isSendingTheReceivedCurrencyInitialsToPresenter() {
        initSut()
        sut.usdCurrencyQuotes = Seeds.APISeeds.exchangeRates.getUSDCurrencyQuotes()
        
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        let expectedResult = "BRL"
        
        sut.convertCurrency(request: CurrencyConversion.ConvertValue.Request(sourceInitials: "USD", sourceValue: "US$1,00", resultInitials: "BRL", textField: .result))
        
        XCTAssertEqual(expectedResult, presenterSpy.formatConvertedCurrencyResponse.currencyInitials)
    }
    
    func testInteractor_afterRunConvertCurrencyWithError_isSendingNegativeOneToPresenter() {
        initSut()
        
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        let expectedResult: Double = -1
        
        sut.convertCurrency(request: CurrencyConversion.ConvertValue.Request(sourceInitials: "USD", sourceValue: "US$1,00", resultInitials: "BRL", textField: .result))
        
        XCTAssertEqual(expectedResult, presenterSpy.formatConvertedCurrencyResponse.number)
    }
}
