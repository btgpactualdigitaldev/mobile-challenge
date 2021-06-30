//
//  CurrencyListResponse.swift
//  iOSBTG
//
//  Created by Filipe Merli on 12/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct CurrencyListResponse: Decodable {
    let success: Bool
    let currencies: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case success
        case currencies
    }
}
