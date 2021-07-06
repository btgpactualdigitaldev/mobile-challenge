//
//  MockURLSessionDataTask.swift
//  CurrencyExchangeTests
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation
@testable import CurrencyExchange

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private(set) var resumeWasCalled = false
    
    func resume(){
        resumeWasCalled = true
    }
    
}
