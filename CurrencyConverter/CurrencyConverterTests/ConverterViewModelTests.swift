//
//  ConverterViewModel.swift
//  CurrencyConverterTests
//
//  Created by Breno Aquino on 29/10/20.
//

import XCTest
@testable import CurrencyConverter

class ConverterViewModelTests: XCTestCase {

    func testTextValueFormmaterNil() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter(nil) == "")
    }
    
    func testTextValueFormmaterEmpty() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("") == "")
    }
    
    func testTextValueFormmaterLetters() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("asdasdasd") == "")
    }
    
    func testTextValueFormmaterNumbersWithComma() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("456,12") == "456.12")
    }
    
    func testTextValueFormmaterNumbersWithDot() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("456.12") == "456.12")
    }
    
    func testTextValueFormmaterOnlyCents() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("56") == "0.56")
    }
    
    func testTextValueFormmaterCentsWithUnit() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("3456") == "34.56")
    }
    
    func testTextValueFormmaterBigNumber() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("4562312351") == "45623123.51")
    }
    
    func testConversor() throws {
        let originCurrency = try? Currecy(code: "BRL", name: "Brazilian Real")
        originCurrency?.inDolarValue = 5.742904
        
        let targetCurrency = try? Currecy(code: "EUR", name: "Euro")
        targetCurrency?.inDolarValue = 0.856348
        
        let viewModel = ConverterViewModel()
        viewModel.originCurrency = originCurrency
        viewModel.targetCurrency = targetCurrency
        
        XCTAssert(viewModel.conversor(value: 1) == "0.15")
    }
}
