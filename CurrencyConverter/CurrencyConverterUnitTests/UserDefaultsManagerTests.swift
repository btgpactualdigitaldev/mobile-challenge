//
//  UserDefaultsManagerTests.swift
//  CurrencyConverterUnitTests
//
//  Created by Isnard Silva on 02/12/20.
//

import XCTest
@testable import CurrencyConverter

class UserDefaultsManagerTests: XCTestCase {
    // MARK: - Properties
    var sut: UserDefaultsManager!
    let objectKeyToSave = "myObject"
    
    // MARK: - Test Methods
    override func setUp() {
        super.setUp()
        sut = UserDefaultsManager()
    }
    
    func testSaveObject() {
        // Given
        let currency = Currency(name: "Real", code: "BRL", valueInDollar: 5)
        
        // When/Then
        XCTAssertNoThrow(try sut.saveObject(currency, forKey: objectKeyToSave))
        XCTAssertNotNil(UserDefaults.standard.object(forKey: objectKeyToSave))
    }
    
    func testGetObject() throws {
        // Given
        let currency = Currency(name: "Real", code: "BRL", valueInDollar: 5)
        try sut.saveObject(currency, forKey: objectKeyToSave)
        
        // When
        let savedObject = try sut.getObject(forKey: objectKeyToSave, castTo: Currency.self)
        
        // Then
        XCTAssertNotNil(savedObject)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        UserDefaults.standard.removeObject(forKey: objectKeyToSave)
    }
}
