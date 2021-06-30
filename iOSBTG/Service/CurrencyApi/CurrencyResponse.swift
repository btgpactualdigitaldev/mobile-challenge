//
//  CurrencyResponse.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct CurrencyResponse: Decodable {
    let success: Bool
    let source: String
    let quotes: [String : Float32]
    
    enum CodingKeys: String, CodingKey {
        case success
        case source
        case quotes
    }
}
