//
//  URLSessionManagerTests.swift
//  CurrencyConverterUnitTests
//
//  Created by Isnard Silva on 02/12/20.
//

import XCTest
@testable import CurrencyConverter

class URLSessionManagerTests: XCTestCase {
    var sut: URLSessionManager!
    
    override func setUp() {
        super.setUp()
        sut = URLSessionManager()
    }
    
    func testConnectionWithAnAPI() {
        // Given
        let baseURL = CurrencyAPISources.baseURL + CurrencyAPISources.currencyNamesExtensionURL
        let parameters: [String: String] = [
            CurrencyAPISources.ParameterName.APIKey: CurrencyAPISources.APIKey
        ]
        let promise = expectation(description: "Completion handler to connect an API")
 
        // When
        sut.get(baseURL: baseURL, parameters: parameters, completionHandler: { (result: Result<CurrencyNamesAPIResponse, NetworkError>) in
            
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(_):
                break
            }
            
            promise.fulfill()
        })
        
        // Then
        wait(for: [promise], timeout: 5)
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

