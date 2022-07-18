//
//  ConversionViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 15/07/22.
//

import Foundation
@testable import CurrencyConverter
import XCTest

final class ConversionViewModelTests: XCTestCase {
    func testOnInitialCurrencyChange() {
        // given
        let serviceMock = ConversionServiceMock()
        let sut = ConversionViewModel(service: serviceMock)
        let delegateMock = ConversionViewModelDelegateMock()
        let expectedCurrency = "AED"
        let mockedCurrency = "USDAED"
        
        // when
        sut.conversionViewModelDelegate = delegateMock
        sut.onInitialCurrencyChange(currency: mockedCurrency)
        
        // then
        
        XCTAssertEqual(expectedCurrency, delegateMock.givenInitialCurrency)
        
    }
    
    func testOnFinalCurrencyChange() {
        // given
        let serviceMock = ConversionServiceMock()
        let sut = ConversionViewModel(service: serviceMock)
        let delegateMock = ConversionViewModelDelegateMock()
        let expectedCurrency = "AED"
        let mockedCurrency = "USDAED"
        
        // when
        sut.conversionViewModelDelegate = delegateMock
        sut.onFinalCurrencyChange(currency: mockedCurrency)
        
        // then
        
        XCTAssertEqual(expectedCurrency, delegateMock.givenFinalCurrency)
    }
    
    func testOnValueChange() {
        // given
        let serviceMock = ConversionServiceMock()
        let sut = ConversionViewModel(service: serviceMock)
        let delegateMock = ConversionViewModelDelegateMock()
        let expectedValue = Float(5.342801)
        let mockedValue = Float(1)
        let mockedInitialCurrency = "USDUSD"
        let mockedFinalCurrency = "USDBRL"
        
        // when
        sut.conversionViewModelDelegate = delegateMock
        serviceMock.quotationResult = .success(QuotationLive(quotes: ["USDUSD": 1, "USDBRL": 5.342801]))
        sut.fetchQuotationLive()
        sut.onInitialCurrencyChange(currency: mockedInitialCurrency)
        sut.onFinalCurrencyChange(currency: mockedFinalCurrency)
        sut.onValueChange(value: mockedValue)
        
        // then
        
        XCTAssertEqual(expectedValue, delegateMock.givenValue)
        
    }
}

class ConversionViewModelDelegateMock: ConversionViewModelDelegate {
    var givenValue: Float?
    var givenInitialCurrency: String?
    var givenFinalCurrency: String?
    
    func convertedValueDidChange(value: Float) {
        givenValue = value
    }
    
    func initialCurrencyDidChange(currency: String) {
        givenInitialCurrency = currency
    }
    
    func finalCurrencyDidChange(currency: String) {
        givenFinalCurrency = currency
    }
}

class ConversionServiceMock: ConversionServiceProtocol {
    var quotationResult: Result<QuotationLive, ServiceError>?
    
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive, ServiceError>) -> Void) {
        guard let quotationResult = quotationResult else {
            return
        }
        
        completion(quotationResult)
    }
    
}
