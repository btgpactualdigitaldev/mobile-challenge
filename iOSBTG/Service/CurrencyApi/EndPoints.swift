//
//  EndPoints.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

enum Endpoints<T: CurrencyApiClient> {
    case getCurrencies
    case listCurrencies

    var url: URL {
        let path: String
        
        switch self {
        case .getCurrencies:
            path = "/live"
        case .listCurrencies:
            path = "/list"
        }            
        
        return URL(string: T.baseURL + path) ?? URL(fileURLWithPath: "https://")
    }
}
