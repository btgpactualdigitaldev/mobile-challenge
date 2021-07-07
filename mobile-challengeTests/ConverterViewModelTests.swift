//
//  ConverterViewModelTests.swift
//  mobile-challengeTests
//
//  Created by Murilo Teixeira on 26/09/20.
//

import XCTest
@testable import mobile_challenge

class ConverterViewModelTests: XCTestCase {
    var viewModel: ConverterViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ConverterViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInputValueIsNil() {
        let expectedError: ValidationError = .inputIsNil
        var testError: ValidationError?
        
        do {
            let _ = try viewModel.inputValidator(nil)
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsEmpty() {
        let expectedError: ValidationError = .inputIsEmpty
        var testError: ValidationError?
        
        do {
            let _ = try viewModel.inputValidator("")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsInvalid() {
        let expectedError: ValidationError = .inputIsNotDouble
        var testError: ValidationError?
        
        do {
            let _ = try viewModel.inputValidator("1.2.")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueFormatContainsComma() {
        let expectedError: ValidationError? = nil
        var testError: ValidationError?
        
        do {
            let _ = try viewModel.inputValidator("1,2")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsNegative() {
        let expectedError: ValidationError? = .valueIsNegative
        var testError: ValidationError?
        
        do {
            let _ = try viewModel.inputValidator("-1,2")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
}
