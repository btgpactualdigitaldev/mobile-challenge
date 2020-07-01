//
//  CurrencyListViewModelTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class CurrencyListViewModelTests: XCTestCase {
    
    func testNumberItens() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        let expectedNumberOfRows: Int = 3
        XCTAssertEqual(expectedNumberOfRows, viewModel.numberOfRows)
        
        
        XCTAssertEqual(expectedNumberOfRows, viewModel.showCurrencies.count)
    }
    
    func testSelectedCurrency() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        let currencyModel = currenciesModel.first!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: currencyModel)
        
        XCTAssertEqual(currencyModel, viewModel.selectedCurrency!)
    }
    
    
    func testBuildCellViewModel() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        let currencyModel = currenciesModel.first!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        let currencyCellViewModel: CurrencyCellViewModel = viewModel.currencyCellViewModel(row: 0)
        
        XCTAssertEqual(currencyModel.symbol.uppercased(), currencyCellViewModel.title)
        XCTAssertEqual(currencyModel.descriptionCurrency, currencyCellViewModel.descriptionCurrency)
    }
    
    func testFilterSymbolOneCaracter() {
        let expectation: XCTestExpectation = self.expectation(description: "Test Filter Symbol")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        viewModel.filter(searchText: "B") {
            
            let expectedResult: Int = 3
            XCTAssertEqual(expectedResult, viewModel.numberOfRows)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testFilterSymbol() {
        let expectation: XCTestExpectation = self.expectation(description: "Test Filter Symbol")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        viewModel.filter(searchText: "BRL") {
            
            let expectedResult: Int = 1
            XCTAssertEqual(expectedResult, viewModel.numberOfRows)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testFilterEmptyResult() {
        let expectation: XCTestExpectation = self.expectation(description: "Test Filter Empty Result")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        viewModel.filter(searchText: "BRLA") {
            
            let expectedResult: Int = 0
            XCTAssertEqual(expectedResult, viewModel.numberOfRows)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testFilterDescription() {
        let expectation: XCTestExpectation = self.expectation(description: "Test Filter Description")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        viewModel.filter(searchText: "Brazilian") {
            
            let expectedResult: Int = 1
            XCTAssertEqual(expectedResult, viewModel.numberOfRows)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testFilterDescriptionEmptyResult() {
        let expectation: XCTestExpectation = self.expectation(description: "Test Filter Description Empty Result")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "currencies")!
        
        let viewModel: CurrencyListViewModel = CurrencyListViewModel(currencies: currenciesModel, selectedCurrency: nil)
        
        viewModel.filter(searchText: "Brazilian X") {
            
            let expectedResult: Int = 0
            XCTAssertEqual(expectedResult, viewModel.numberOfRows)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
}
