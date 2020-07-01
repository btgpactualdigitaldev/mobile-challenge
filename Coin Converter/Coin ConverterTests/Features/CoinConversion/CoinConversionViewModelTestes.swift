//
//  CoinConversionViewModelTestes.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 30/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class CoinConversionViewModelTestes: XCTestCase {

    func testDefaultSelect() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                
                let expectedOriginSymbol: String = "BRL"
                XCTAssertEqual(expectedOriginSymbol, viewModel.selectedOriginCurrency?.symbol)
                
                let expectedOriginDescription: String = "Brazilian Real"
                XCTAssertEqual(expectedOriginDescription, viewModel.selectedOriginCurrency?.descriptionCurrency)
                
                let expectedDestinySymbol: String = "USD"
                XCTAssertEqual(expectedDestinySymbol, viewModel.selectedDestinyCurrency?.symbol)
                
                let expectedDestinyDescription: String = "United States Dollar"
                XCTAssertEqual(expectedDestinyDescription, viewModel.selectedDestinyCurrency?.descriptionCurrency)
            }
            expectation.fulfill()
        })
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testDefaultSelectNull() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainerEmptCurrency", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                
                XCTAssertNil(viewModel.selectedOriginCurrency)
                XCTAssertNil(viewModel.selectedDestinyCurrency)
            }
            expectation.fulfill()
        })
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testErrorDefaultSelect() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "error", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "The data could not be read."
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
             expectation.fulfill()
        })
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testErrorServerDefaultSelect() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "empty", statusCode: 500, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "The data couldn’t be read because it isn’t in the correct format."
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
             expectation.fulfill()
        })
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testConversion() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        viewModel.selectedDestinyCurrency = currenciesModel.last!
        
        viewModel.convertCurrency(value: "10,00") { (convertedValue, error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                let expectedConvertedValue: String = "1.83"
                XCTAssertEqual(expectedConvertedValue, String(format: "%.2f", convertedValue!))
                
                let expectedPriceDate: String = "27/06/2020 13:37"
                XCTAssertEqual(expectedPriceDate, viewModel.priceDate)
                
                let expectedOnePrice: String = "0.18"
                XCTAssertEqual(expectedOnePrice, String(format: "%.2f", viewModel.onePrice))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionOtherCurrency() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2SymbolsOtherUSD")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        viewModel.selectedDestinyCurrency = currenciesModel.last!
        
        viewModel.convertCurrency(value: "10,00") { (convertedValue, error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                let expectedConvertedValue: String = "17795.09"
                XCTAssertEqual(expectedConvertedValue, String(format: "%.2f", convertedValue!))
                
                let expectedPriceDate: String = "27/06/2020 13:37"
                XCTAssertEqual(expectedPriceDate, viewModel.priceDate)
                
                let expectedOnePrice: String = "1779.51"
                XCTAssertEqual(expectedOnePrice, String(format: "%.2f", viewModel.onePrice))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionEmpySelectionCurrencies() {
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.convertCurrency(value: "10,00") { (convertedValue, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "Select the currency of origin and destination"
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionEmpyDestinyCurrencies() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        
        viewModel.convertCurrency(value: "10,00") { (convertedValue, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "Select the currency of origin and destination"
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionEmpyOriginCurrencies() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        
        viewModel.convertCurrency(value: "10,00") { (convertedValue, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "Select the currency of origin and destination"
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionInvalidValue() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        viewModel.selectedDestinyCurrency = currenciesModel.last!
        
        viewModel.convertCurrency(value: "ab") { (convertedValue, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "Invalid value"
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testConversionInvalidEmpyValue() {
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let expectation = self.expectation(description: "Request Quotes")
        let session = Utils.createSession(with: "QuotesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.selectedOriginCurrency = currenciesModel.first!
        viewModel.selectedDestinyCurrency = currenciesModel.last!
        
        viewModel.convertCurrency(value: "") { (convertedValue, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "Invalid value"
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testErrorConversion() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "error", statusCode: 500, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.convertCurrency(value: "1,00") { (_, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "The data could not be read."
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
             expectation.fulfill()
        }
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testErrorServerConversion() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "empty", statusCode: 500, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.convertCurrency(value: "1,00") { (_, error) in
            if error == nil {
                XCTFail("should return the error object")
            } else {
                let expectedErrorMessage: String = "The data couldn’t be read because it isn’t in the correct format."
                XCTAssertEqual(expectedErrorMessage, error!.localizedDescription)
            }
             expectation.fulfill()
        }
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testSelectedCurrencyInvert() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                
                viewModel.invertCurrency()
                
                let expectedOriginSymbol: String = "USD"
                XCTAssertEqual(expectedOriginSymbol, viewModel.selectedOriginCurrency?.symbol)
                
                let expectedOriginDescription: String = "United States Dollar"
                XCTAssertEqual(expectedOriginDescription, viewModel.selectedOriginCurrency?.descriptionCurrency)
                
                let expectedDestinySymbol: String = "BRL"
                XCTAssertEqual(expectedDestinySymbol, viewModel.selectedDestinyCurrency?.symbol)
                
                let expectedDestinyDescription: String = "Brazilian Real"
                XCTAssertEqual(expectedDestinyDescription, viewModel.selectedDestinyCurrency?.descriptionCurrency)
            }
            expectation.fulfill()
        })
        
         waitForExpectations(timeout: 4.0)
    }
    
    func testOriginListViewModel() {
        let expectation = self.expectation(description: "Request Currencies")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                
                viewModel.selectedOriginCurrency = currenciesModel.first!
                       
                let currencyListViewModel: CurrencyListViewModel? = viewModel.currencyListViewModel(currencyType: .origin)
                
                XCTAssertNotNil(currencyListViewModel)
                
                let expectedSymbol: String = "BRL"
                XCTAssertEqual(expectedSymbol, currencyListViewModel?.selectedCurrency?.symbol)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testOriginEmptyListViewModel() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
               
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                viewModel.selectedOriginCurrency = nil
                
                let currencyListViewModel: CurrencyListViewModel? = viewModel.currencyListViewModel(currencyType: .origin)
                
                XCTAssertNotNil(currencyListViewModel)
                XCTAssertNil(currencyListViewModel?.selectedCurrency)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testDestinyListViewModel() {
        let expectation = self.expectation(description: "Request Currencies")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies2Symbols")!
        
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                
                viewModel.selectedDestinyCurrency = currenciesModel.last!
                       
                let currencyListViewModel: CurrencyListViewModel? = viewModel.currencyListViewModel(currencyType: .destiny)
                
                XCTAssertNotNil(currencyListViewModel)
                
                let expectedSymbol: String = "USD"
                XCTAssertEqual(expectedSymbol, currencyListViewModel?.selectedCurrency?.symbol)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testDestinyEmptyListViewModel() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
               
        viewModel.requestCurrencies(completion: { (error) in
            if let error: Error = error {
                XCTFail("Should not fail with error: \(error.localizedDescription)")
            } else {
                viewModel.selectedDestinyCurrency = nil
                
                let currencyListViewModel: CurrencyListViewModel? = viewModel.currencyListViewModel(currencyType: .destiny)
                
                XCTAssertNotNil(currencyListViewModel)
                XCTAssertNil(currencyListViewModel?.selectedCurrency)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testOriginUpdateCurrency() {
        let expectation = self.expectation(description: "Request Currencies")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies1Symbol")!
        
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        XCTAssertNil(viewModel.selectedOriginCurrency)
        
        viewModel.updateCurrency(currencyType: .origin, currencyModel: currenciesModel.first!, completion: {
            
            XCTAssertNotNil(viewModel.selectedOriginCurrency)
            
            let expectedSymbol: String = "SLL"
            XCTAssertEqual(expectedSymbol, viewModel.selectedOriginCurrency?.symbol)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testDestinyUpdateCurrency() {
        let expectation = self.expectation(description: "Request Currencies")
        let currenciesModel: [CurrencyModel] = Utils.loadJsonToModel(with: "Currencies1Symbol")!
        
        let session = Utils.createSession(with: "CurrenciesContainer2Symbols", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: currencyLayerService)
        
        XCTAssertNil(viewModel.selectedDestinyCurrency)
        
        viewModel.updateCurrency(currencyType: .destiny, currencyModel: currenciesModel.first!, completion: {
            
            XCTAssertNotNil(viewModel.selectedDestinyCurrency)
            
            let expectedSymbol: String = "SLL"
            XCTAssertEqual(expectedSymbol, viewModel.selectedDestinyCurrency?.symbol)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0)
    }
    
}
