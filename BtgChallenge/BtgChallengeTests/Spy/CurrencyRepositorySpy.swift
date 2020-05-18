//
//  CurrencyRepositorySpy.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation
@testable import BtgChallenge

class CurrencyRepositorySpy: CurrencyRepository {
    var liveCalled = false
    var convertCalled = false
    var listCalled = false
    var isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func live(_ currencies: String, _ source: String, _ callback: @escaping (LiveResult) -> Void) {
        liveCalled = true
        
        if isSuccess {
            let liveResponse = MockFactory.createLiveResponse()
            callback(.success(liveResponse))
        } else {
            callback(.failure(MockFactory.createError()))
        }
    }
    
    func convert(_ fromCoin: String,
                 _ toCoin: String,
                 _ amount: String,
                 _ callback: @escaping (ConvertResult) -> Void
    ) {
        convertCalled = true
    }
    
    func list(_ callback: @escaping (ListResult) -> Void) {
        listCalled = true
        
        if isSuccess {
            let liveResponse = MockFactory.createListResponse()
            callback(.success(liveResponse))
        } else {
            callback(.failure(MockFactory.createError()))
        }
    }
}
