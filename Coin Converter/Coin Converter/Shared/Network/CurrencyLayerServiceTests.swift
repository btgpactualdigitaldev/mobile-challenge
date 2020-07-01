//
//  CurrencyLayerServiceTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 30/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class CurrencyLayerServiceTests: XCTestCase {
    
    func testRequestCurrencies() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "CurrenciesContainer", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        currencyLayerService.requestCurrencies { (model, error) in
            if error != nil {
                XCTFail("Should not fail with error: \(error!.localizedDescription)")
            } else {
                XCTAssertNotNil(model)
                
                let expectedTotal: Int = 168
                XCTAssertEqual(expectedTotal, model?.count)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testErrorRequestCurrencies() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "error", statusCode: 200, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        currencyLayerService.requestCurrencies { (model, error) in
            if model != nil {
                XCTFail("Must not have the model")
            } else if let error: Error = error {
                
                let expectedErrorMessage: String = "The data could not be read."
                XCTAssertEqual(expectedErrorMessage, error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }
    
    func testErrorServerRequestCurrencies() {
        let expectation = self.expectation(description: "Request Currencies")
        let session = Utils.createSession(with: "empty", statusCode: 500, error: nil)
        
        let currencyLayerService: CurrencyLayerService = CurrencyLayerService(withSession: session!)
        
        currencyLayerService.requestCurrencies { (model, error) in
            if model != nil {
                XCTFail("Must not have the model")
            } else if let error: Error = error {
                
                let expectedErrorMessage: String = "The data couldn’t be read because it isn’t in the correct format."
                XCTAssertEqual(expectedErrorMessage, error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0)
    }

}
