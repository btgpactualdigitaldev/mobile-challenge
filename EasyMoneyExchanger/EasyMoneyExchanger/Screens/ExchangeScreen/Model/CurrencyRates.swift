//
//  RealTimeRatesModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation

struct CurrencyRates: Codable {
    let timestamp: Int
    let quotes: [String: Float]
}
