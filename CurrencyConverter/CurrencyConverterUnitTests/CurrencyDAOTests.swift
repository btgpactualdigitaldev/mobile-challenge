//
//  CurrencyDAOTests.swift
//  CurrencyConverterUnitTests
//
//  Created by Isnard Silva on 03/12/20.
//

import XCTest
@testable import CurrencyConverter

class CurrencyDAOTests: XCTestCase {
    // MARK: - Properties
    var sut: CurrencyDAO!
    
    
    // MARK: Test Methods
    override func setUp() {
        super.setUp()
        sut = CurrencyDAO()
    }
    
    func testSaveCurrencies() {
        // Given
        let currencies = self.generateFakeCurrencies()
        
        // When/Then
        XCTAssertNoThrow(try sut.saveCurrencies(currencies: currencies))
        XCTAssertNotNil(UserDefaults.standard.object(forKey: Identifier.Database.name))
    }
    
    func testFetchCurrencies() throws {
        // Given
        let currenciesToSave = self.generateFakeCurrencies()
        try sut.saveCurrencies(currencies: currenciesToSave)
        
        // When
        XCTAssertNoThrow(try sut.fetchCurrencies())
        if let savedCurrencies = try? sut.fetchCurrencies(), savedCurrencies.isEmpty {
            XCTFail("Currency Array is empty")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        UserDefaults.standard.removeObject(forKey: Identifier.Database.name)
    }
}


// MARK: - Handle Fake Currencies
extension CurrencyDAOTests {
    private func generateFakeCurrencies() -> [Currency] {
        var currencies: [Currency] = []
        
        currencies.append(Currency(name: "Real", code: "BRL", valueInDollar: 5))
        currencies.append(Currency(name: "Dollar", code: "USD", valueInDollar: 1))
        
        return currencies
    }
}
