//
//  CurrencyLiveRateService.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import Foundation

class CurrencyLiveRateService: CurrencyLiveRateProviding {
    var network: Networking

    init(network: Networking) {
        self.network = network
    }
}
