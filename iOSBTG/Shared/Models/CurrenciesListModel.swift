//
//  CurrenciesListModel.swift
//  iOSBTG
//
//  Created by Filipe Merli on 13/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct CurrenciesListModel: Decodable {
    
    let currencies: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case currencies
    }
}
