//
//  CurrenciesViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 16/07/22.
//

import Foundation
@testable import CurrencyConverter
import XCTest

final class CurrenciesViewModelTests: XCTestCase {
    
    func testOnLoadSuccess() {
        // given
        let serviceMock = CurrenciesServiceMock()
        let delegateMock = CurrenciesViewModelDelegateMock()
        let sut = CurrenciesViewModel(service: serviceMock)
        
        // when
        sut.currenciesDelegate = delegateMock
        serviceMock.result = .success(Currencies(currencies: [:]))
        sut.onLoad()
        
        // then
        XCTAssertTrue(delegateMock.didFetchCurrenciesCalled)
        XCTAssertFalse(delegateMock.didFailToFetchCurrenciesCalled)
    }
    
    func testOnLoadFailure() {
        // given
        let serviceMock = CurrenciesServiceMock()
        let delegateMock = CurrenciesViewModelDelegateMock()
        let sut = CurrenciesViewModel(service: serviceMock)
        
        // when
        sut.currenciesDelegate = delegateMock
        serviceMock.result = .failure(ServiceError.parseError)
        sut.onLoad()
        
        // then
        XCTAssertTrue(delegateMock.didFailToFetchCurrenciesCalled)
        XCTAssertFalse(delegateMock.didFetchCurrenciesCalled)
    }
    
    func testGetCurrency() {
        // given/when
        let expectedCurrencyName = "United Arab Emirates Dirham"
        let sut = buildCurrenciesViewModel(currencies: Currencies(currencies: ["AED": expectedCurrencyName]))
        guard let currencyName = sut.getCurrencyName(index: 0) else { return }
        
        // then
        XCTAssertEqual(expectedCurrencyName, currencyName)
    }
    
    func testGetCurrencyInitials() {
        // given/when
        let expectedCurrencyInitials = "AED"
        let sut = buildCurrenciesViewModel(currencies: Currencies(currencies: [expectedCurrencyInitials: "United Arab Emirates Dirham"]))
        guard let currencyInitials = sut.getCurrencyInitials(index: 0) else { return }
        
        // then
        XCTAssertEqual(expectedCurrencyInitials, currencyInitials)
    }
    
    func testCurrenciesCount() {
        // given/when
        let expectedCount = 1
        let sut = buildCurrenciesViewModel(currencies: Currencies(currencies: ["AED": "United Arab Emirates Dirham"]))
        guard let currenciesCount = sut.currenciesCount() else { return }
        
        // then
        XCTAssertEqual(expectedCount, currenciesCount)
    }
    
    private func buildCurrenciesViewModel(currencies: Currencies) -> CurrenciesViewModel {
        let serviceMock = CurrenciesServiceMock()
        let sut = CurrenciesViewModel(service: serviceMock)
        serviceMock.result = .success(currencies)
        sut.onLoad()
        
        return sut
    }
    
}

class CurrenciesViewModelDelegateMock: CurrenciesViewModelDelegate {
    
    private(set) var didFetchCurrenciesCalled: Bool = false
    private(set) var didFailToFetchCurrenciesCalled: Bool = false
    
    func didFetchCurrencies() {
        didFetchCurrenciesCalled = true
    }
    
    func didFailToFetchCurrencies() {
        didFailToFetchCurrenciesCalled = true
    }
}

class CurrenciesServiceMock: CurrenciesServiceProtocol {
    
    var result: Result<Currencies, ServiceError>?
    
    func fetchCurrencyList(completion: @escaping (Result<Currencies, ServiceError>) -> Void) {
        guard let result = result else { return }
        completion(result)
    }
    
}
