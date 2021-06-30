//
//  CurrencyConverterModel.swift
//  iOSBTG
//
//  Created by Filipe Merli on 14/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct CurrencyConverterModel: Decodable {
    
    let quotes: [String : Float32]
    
    enum CodingKeys: String, CodingKey {
        case quotes
    }
}
