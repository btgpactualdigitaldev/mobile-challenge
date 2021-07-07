//
//  NetworkSupportedCurrenciesWorkerTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class NetworkSupportedCurrenciesWorkerTests: XCTestCase {
    var sut: NetworkSupportedCurrenciesWorker<DataManagerMock<Data>>!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func initSutWithSupportedCurrencies() {
        let returnData = try? JSONEncoder().encode(Seeds.APISeeds.supportedCurrencies)
        let dataManager = DataManagerMock(returnData: returnData)
        sut = NetworkSupportedCurrenciesWorker(dataManager: dataManager)
    }
    
    private func initSutWithExchangeRates() {
        let returnData = try? JSONEncoder().encode(Seeds.APISeeds.exchangeRates)
        let dataManager = DataManagerMock(returnData: returnData)
        sut = NetworkSupportedCurrenciesWorker(dataManager: dataManager)
    }
    
    private func initSutWithError() {
        let dataManager = DataManagerMock<Data>(returnError: NetworkDataManagerError.requestError, returnData: nil)
        sut = NetworkSupportedCurrenciesWorker(dataManager: dataManager)
    }
    
    func testWorker_whenDataManagerReturnError_returnCompletionWithRequestError() {
        initSutWithError()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.loadSupportedCurrencies { (currencies, error) in
            XCTAssertEqual(NetworkSupportedCurrenciesWorkerError.requestError, error as? NetworkSupportedCurrenciesWorkerError)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
    
    func testWorker_whenDataManagerReturnInvalidData_returnCompletionWithDecodeError() {
        initSutWithExchangeRates()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.loadSupportedCurrencies { (currencies, error) in
            XCTAssertEqual(NetworkSupportedCurrenciesWorkerError.cannotDecodeData, error as? NetworkSupportedCurrenciesWorkerError)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
    
    func testWorker_returnCompletionWithSupportedCurrencies() {
        initSutWithSupportedCurrencies()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.loadSupportedCurrencies { (currencies, error) in
            XCTAssertEqual(Seeds.APISeeds.supportedCurrencies, currencies)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
}
