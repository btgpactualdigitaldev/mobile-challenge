//
//  PersistenceManagerTests.swift
//  Apply-BTGTests
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import XCTest
@testable import Apply_BTG

class PersistenceManagerTests: XCTestCase {
    // MARK: - SUT
    var sut: PersistenceManager!
    
    // MARK: - DOUBLES
    let doubleCurrency = Currency(code: "SL", name: "Sal")
    let doubleCurrencies = [Currency(code: "SL", name: "Sal"), Currency(code: "CMD", name: "Comida"), Currency(code: "ANM", name: "Animais")]
    
    let doubleQuotes = ConversionQuotes(source: "BKB", all: ["AAA": 1.232, "ZZZ": 1.2, "PHP": 2.33])
    
    // MARK: - SETUP METHODS
    override func setUpWithError() throws {
        sut = UserDefaultsPersistenceManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        UserDefaults.resetStandardUserDefaults()
    }
    
    // MARK: - SAVE TEST
    
    /// Ensures a `Currency` object is saved successfully
    /// - Throws: a failure in the assertion if the object cannot be saved
    func testSaveACurrencySuccessfully() throws {
        XCTAssertTrue(sut.saveCurrency(doubleCurrency, withKey: "test"))
    }
    
    /// Ensures a `Currency` array object is saved successfully
    /// - Throws: a failure in the assertion if the array object cannot be saved
    func testSaveAnCurrencyArraySuccessfully() throws {
        XCTAssertTrue(sut.saveCurrencies(doubleCurrencies, withKey: "testArray"))
    }
    
    /// Ensures a `ConversionQuotes`  object is saved successfully
    /// - Throws: a failure in the assertion if the object cannot be saved
    func testSaveAConversionQuoteSuccessfully() throws {
        XCTAssertTrue(sut.saveConversionQuotes(doubleQuotes, withKey: "testQuote"))
    }
    
    // MARK: - REMOVE TEST
        
    /// Ensures a `Currency` object is deleted successfully
    /// - Throws: a failure in the assertion if the object cannot be deleted
    func testRemoveACurrencySuccessfully() throws {
        _ = sut.saveCurrency(doubleCurrency, withKey: "testObject")
        XCTAssertTrue(sut.deleteCurrency(withKey: "testObject"))
    }
            
    /// Ensures a `Currency` array object is deleted successfully
    /// - Throws: a failure in the assertion if the array object caanot be deleted
    func testRemoveACurrencyArraySuccessfully() throws {
        _ = sut.saveCurrencies(doubleCurrencies, withKey: "testArray")
        XCTAssertTrue(sut.deleteCurrencies(withKey: "testArray"))
    }
    
    /// Ensures a `ConversionQuotes` object is deleted successfully
    /// - Throws: a failure in the assertion if the object cannot be deleted
    func testRemoveConversionQuotesSuccessfully() throws {
        _ = sut.saveConversionQuotes(doubleQuotes, withKey: "testQuote")
        XCTAssertTrue(sut.deleteConversionQuotes(withKey: "testQuote"))
    }
    
    /// Ensures a delete operation will fail when using a wrong key when deleting a `Currency`
    /// - Throws: a failure in the assertion if the deletion occurs successfully
    func testFailWhenTryingToRemoveACurrencyWithWrongKey() throws {
        _ = sut.saveCurrency(doubleCurrency, withKey: "testObject")
        XCTAssertFalse(sut.deleteCurrency(withKey: "Ouch"))
    }
    
    /// Ensures a delete operation will fail when using a wrong key when deleting a `Currency` array
    /// - Throws: a failure in the assertion if the deletion occurs successfully
    func testFailWhenTryingToRemoveACurrencyArrayWithWrongKey() throws {
        _ = sut.saveCurrencies(doubleCurrencies, withKey: "testArray")
        XCTAssertFalse(sut.deleteCurrencies(withKey: "Ouch"))
    }
        
    /// Ensures a delete operation will fail when using a wrong key when deleting a `ConversionQuotes`
    /// - Throws: a failure in the assertion if the deletion occurs successfully
    func testRemoveConversionQuotesWithWrongKey() throws {
        _ = sut.saveConversionQuotes(doubleQuotes, withKey: "testQuote")
        XCTAssertFalse(sut.deleteConversionQuotes(withKey: "Ouch"))
    }
    
    // MARK: - GET TESTS
    func testGetCurrencySuccessfullyWithValidKey() throws {
        _ = sut.saveCurrency(doubleCurrency, withKey: "testObject")
        XCTAssertNotNil(sut.getCurrency(withKey: "testObject"))
    }
    
    func testFailWhenGetCurrencyWithWrongKey() throws {
        _ = sut.saveCurrency(doubleCurrency, withKey: "testObject")
        XCTAssertNil(sut.getCurrency(withKey: "Ouch"))
    }
    
    func testGetCurrenciesArraySuccessfullyWithValidKey() throws {
        _ = sut.saveCurrencies(doubleCurrencies, withKey: "testArray")
        XCTAssertNotNil(sut.getCurrencies(withKey: "testArray"))
    }
    
    func testFailWhenGetCurrenciesArrayWithWrongKey() throws {
        _ = sut.saveCurrencies(doubleCurrencies, withKey: "testArray")
        XCTAssertNil(sut.getCurrencies(withKey: "Ouch"))
    }
    
    
    func testGetConversionQuotesSuccessfullyWithValidKey() throws {
        _ = sut.saveConversionQuotes(doubleQuotes, withKey: "testQuote")
        XCTAssertNotNil(sut.getConversionQuotes(withKey: "testQuote"))
    }
    
    func testFailWhenGetConversionQuotesWithWrongKey() throws {
        _ = sut.saveConversionQuotes(doubleQuotes, withKey: "testQuote")
        XCTAssertNil(sut.getConversionQuotes(withKey: "Ouch"))
    }
}
