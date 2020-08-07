//
//  MockCurrencyClient.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

class MockCurrencyClient {
    public var synchronizeQuotesIsCalled = false
}

extension MockCurrencyClient: CurrencyClientProtocol {
    func synchronizeQuotes(result: @escaping SynchronyzeQuotesResponse) {
        synchronizeQuotesIsCalled = true
    }
}
