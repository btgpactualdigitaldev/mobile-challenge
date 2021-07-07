//
//  NetworkExchangeRatesWorkerTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class NetworkExchangeRatesWorkerTests: XCTestCase {
    var sut: NetworkExchangeRatesWorker<DataManagerMock<Data>>!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func initSutWithSupportedCurrencies() {
        let returnData = try? JSONEncoder().encode(Seeds.APISeeds.supportedCurrencies)
        let dataManager = DataManagerMock(returnData: returnData)
        sut = NetworkExchangeRatesWorker(dataManager: dataManager)
    }
    
    private func initSutWithExchangeRates() {
        let returnData = try? JSONEncoder().encode(Seeds.APISeeds.exchangeRates)
        let dataManager = DataManagerMock(returnData: returnData)
        sut = NetworkExchangeRatesWorker(dataManager: dataManager)
    }
    
    private func initSutWithError() {
        let dataManager = DataManagerMock<Data>(returnError: NetworkDataManagerError.requestError, returnData: nil)
        sut = NetworkExchangeRatesWorker(dataManager: dataManager)
    }
    
    func testWorker_whenDataManagerReturnError_returnCompletionWithRequestError() {
        initSutWithError()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.getExchangeRates(completion: { (exchangeRates, error) in
            XCTAssertEqual(NetworkExchangeRatesWorkerError.requestError, error as? NetworkExchangeRatesWorkerError)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 0.2)
    }
    
    func testWorker_returnCompletionWithExchangeRates() {
        initSutWithExchangeRates()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.getExchangeRates(completion: { (exchangeRates, error) in
            XCTAssertEqual(Seeds.APISeeds.exchangeRates, exchangeRates)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 0.2)
    }
    
    func testWorker_whenDataManagerReturnInvalidData_returnCompletionWithDecodeError() {
        initSutWithSupportedCurrencies()
        
        let expect = expectation(description: "Wait for API result to return")
        sut.getExchangeRates(completion: { (exchangeRates, error) in
            XCTAssertEqual(NetworkExchangeRatesWorkerError.cannotDecodeData, error as? NetworkExchangeRatesWorkerError)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 0.2)
    }
}
