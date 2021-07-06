//
//  CurrencyMockData.swift
//  CurrencyExchangeTests
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation

class CurrencyMockData {
    var data = """
    {"success": true,
    "currencies": {
    "AED": "United Arab Emirates Dirham",
    "AFN": "Afghan Afghani",
    "ALL": "Albanian Lek",
    "AMD": "Armenian Dram"
    }}

    """.data(using: .utf8)
    
    var dataError = """
    "success": true,
    "currencies": {
    "AED": "United Arab Emirates Dirham",
    "AFN": "Afghan Afghani",
    "ALL": "Albanian Lek",
    "AMD": "Armenian Dram"
    

    """.data(using: .utf8)
}
