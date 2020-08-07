//
//  MockNetworkHelper.swift
//  BTGCurrencyTests
//
//  Created by Raphael Martin on 06/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

class MockConnectedNetworkHelper: NetworkHelperProtocol {
    func isConnected() -> Bool {
        return true
    }
}

class MockNotConnectedNetworkHelper: NetworkHelperProtocol {
    func isConnected() -> Bool {
        return false
    }
}
