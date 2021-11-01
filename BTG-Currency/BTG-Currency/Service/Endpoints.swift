//
//  Endpoints.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public enum Endpoints {
    var domain: String {
        "https://btg-mobile-challenge.herokuapp.com"
    }
    
    case list
    case live
    
    var url: URL {
        switch self {
        case .list:
            return URL(string: domain + "/list")!
        case .live:
            return URL(string: domain + "/live")!
        }
    }
}
