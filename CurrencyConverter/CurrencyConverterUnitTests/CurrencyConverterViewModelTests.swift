//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterUnitTests
//
//  Created by Isnard Silva on 02/12/20.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterViewModelTests: XCTestCase {
    // MARK: - Properties
    var sut: CurrencyConverterViewModel!
    
    /// Enum que especifica se é a moeda de destino ou a origem
    enum CurrencyType {
        case source
        case target
    }
    
    
    
    // MARK: - Test Methods
    override func setUp() {
        super.setUp()
        sut = CurrencyConverterViewModel()
    }
    
    func testEmptySourceCurrency() {
        // Given
        sut.insertTargetCurrency(currency: getFakeCurrency(type: .target))
        sut.insertValueToConvert(value: 10.0)
        
        
        // When
        XCTAssertThrowsError(try sut.convertCurrencies()) { error in
            // Then
            XCTAssertEqual(error as? CurrencyConverterError, CurrencyConverterError.emptySourceCurrency)
        }
    }
    
    func testEmptyTargetCurrency() {
        // Given
        sut.insertSourceCurrency(currency: getFakeCurrency(type: .source))
        sut.insertValueToConvert(value: 10.0)
        
        
        // When
        XCTAssertThrowsError(try sut.convertCurrencies()) { error in
            // Then
            XCTAssertEqual(error as? CurrencyConverterError, CurrencyConverterError.emptyTargetCurrency)
        }
    }
    
    func testEmptyValueToConvert() {
        // Given
        sut.insertSourceCurrency(currency: getFakeCurrency(type: .source))
        sut.insertTargetCurrency(currency: getFakeCurrency(type: .target))
        
        // When
        XCTAssertThrowsError(try sut.convertCurrencies()) { error in
            // Then
            XCTAssertEqual(error as? CurrencyConverterError, CurrencyConverterError.emptyValueToConvert)
        }
    }
    
    func testValueToConvertEqualZero() {
        // Given
        sut.insertSourceCurrency(currency: getFakeCurrency(type: .source))
        sut.insertTargetCurrency(currency: getFakeCurrency(type: .target))
        sut.insertValueToConvert(value: 0)
        
        // When
        XCTAssertThrowsError(try sut.convertCurrencies()) { error in
            // Then
            XCTAssertEqual(error as? CurrencyConverterError, CurrencyConverterError.emptyValueToConvert)
        }
    }
    
    func testCurrencyConverter() throws {
        // Given
        sut.insertSourceCurrency(currency: getFakeCurrency(type: .source))
        sut.insertTargetCurrency(currency: getFakeCurrency(type: .target))
        sut.insertValueToConvert(value: 2)
        
        // When
        let resultOfConversion = try sut.convertCurrencies()
        
        // Then
        XCTAssertEqual(resultOfConversion, 30.96484023440858)
    }
    
    
    override func tearDown() {
        super.setUp()
        sut = nil
    }
}



// MARK: - Handle Fake Currencies
extension CurrencyConverterViewModelTests {
    /// Fornece objetos Currency para facilitar a realização dos testes
    private func getFakeCurrency(type: CurrencyType) -> Currency {
        switch type {
        case .source:
            return Currency(name: "Real", code: "BRL", valueInDollar: 5.257828)
        case .target:
            return Currency(name: "Peso Argentino", code: "ARS", valueInDollar: 81.403902)
        }
    }
}
