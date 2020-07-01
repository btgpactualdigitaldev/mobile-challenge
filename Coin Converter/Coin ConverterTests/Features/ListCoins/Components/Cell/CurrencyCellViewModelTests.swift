//
//  CurrencyCellViewModelTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class CurrencyCellViewModelTests: XCTestCase {

    func testProperties() {
        let currencyModel : CurrencyModel = CurrencyModel(symbol: "BRL", descriptionCurrency: "Brazilian Real")
        let viewModel: CurrencyCellViewModel = CurrencyCellViewModel(currencyModel: currencyModel, selectedSymbol: "")
        
        let expectedTitle: String = "BRL"
        XCTAssertEqual(expectedTitle, viewModel.title)
        
        let expectedDescription: String = "Brazilian Real"
        XCTAssertEqual(expectedDescription, viewModel.descriptionCurrency)
    }
    
    func testSelected() {
        let currencyModel : CurrencyModel = CurrencyModel(symbol: "BRL", descriptionCurrency: "Brazilian Real")
        let viewModel: CurrencyCellViewModel = CurrencyCellViewModel(currencyModel: currencyModel, selectedSymbol: "BRL")
        
        let isSelected: Bool = true
        XCTAssertEqual(isSelected, viewModel.isSelected)
    }
    
    func testNotSelected() {
        let currencyModel : CurrencyModel = CurrencyModel(symbol: "BRL", descriptionCurrency: "Brazilian Real")
        let viewModel: CurrencyCellViewModel = CurrencyCellViewModel(currencyModel: currencyModel, selectedSymbol: "USD")
        
        let isSelected: Bool = false
        XCTAssertEqual(isSelected, viewModel.isSelected)
    }

}
