//
//  CurrencyViewModelTests.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

import UIKit
import XCTest
@testable import Curriencies

final class DelegateDummy: ChangeCurrencyDelegate {
    private(set) var callUpdateNewCurrency = 0
    private(set) var titleReceive = ""
    private(set) var typeReceive = CurrencyType.origin
    
    func updateNewCurrency(title: String, type: CurrencyType) {
        callUpdateNewCurrency += 1
        titleReceive = title
        typeReceive = type
    }
}

final class CurrencyViewModelTests: XCTestCase {
    let getCurrencySpy = GetCurrencyUseCaseSpy()
    let calculateCurrencySpy = CalculateCurrencyUseCaseSpy()
    lazy var sut = CurrencyViewModel(getCurrenciesUseCase: getCurrencySpy,
                                     calculateCurrencyUseCase: calculateCurrencySpy)
    
    let currencyDummy: [CurrencyEntity] = [
        CurrencyEntity(code: "BRL", name: "Brazilian Real", value: 5),
        CurrencyEntity(code: "USD", name: "American Dolar", value: 1)
    ]

    func testGetCurrencies_WhenReceiveError_ShouldReturnDefaultValue() {
        getCurrencySpy.setError(.generic)
        
        sut.getCurrencies { [weak self] (success, value) in
            XCTAssertFalse(success)
            XCTAssertEqual(value, "1.00")
            XCTAssertEqual(self?.calculateCurrencySpy.callCalculateCurrency, 0)
            XCTAssertEqual(self?.getCurrencySpy.callGetCurrencies, 1)
        }
    }
    
    func testGetCurrencies_WhenReceiveEntities_ShouldReturnDolarToRealValue() {
        getCurrencySpy.setSuccess(entities: currencyDummy)
        calculateCurrencySpy.setValue(5)
        
        sut.getCurrencies { [weak self] (success, value) in
            XCTAssertTrue(success)
            XCTAssertEqual(value, "5.00")
            XCTAssertEqual(self?.calculateCurrencySpy.callCalculateCurrency, 1)
            XCTAssertEqual(self?.getCurrencySpy.callGetCurrencies, 1)
        }
    }

    func testGetValue_WhenReceiveValue_ShouldReturnValueFormated() {
        calculateCurrencySpy.setValue(5)
        
        let value = sut.getValue(originValue: 5)
        
        XCTAssertEqual(value, "5.00")
    }
    
    func testGoToCurrencyList_WhenButtonPressed_ShouldReturnNextViewController() {
        let delegate = DelegateDummy()
        
        let viewController = sut.goToCurrencyList(currencyType: .origin,
                                                  delegate: delegate)
        
        XCTAssertNotNil(viewController as? CurrencyListViewController)
    }
    
    func testUpdateCurrency_WhenDestinationWillChange_ShouldChangeDestination() {
        _ = sut.updateCurrency(code: "ABC", type: .destination)
        
        XCTAssertEqual(sut.destinationCode, calculateCurrencySpy.destinationCodeReceive)
        XCTAssertEqual(calculateCurrencySpy.callCalculateCurrency, 1)
    }
    
    func testUpdateCurrency_WhenOriginWillChange_ShouldChangeOrigin() {
        _ = sut.updateCurrency(code: "ABC", type: .origin)
        
        XCTAssertEqual(sut.originCode, calculateCurrencySpy.originCodeReceive)
        XCTAssertEqual(calculateCurrencySpy.callCalculateCurrency, 1)
    }
}
