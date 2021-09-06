//
//  EndPoint.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

enum Endpoint {
    case live
    case list
    
    var url: String {
        let base = "https://btg-mobile-challenge.herokuapp.com/"
        switch self {
        case .live:
            return base + "live"
        case .list:
            return base + "list"
        }
    }
}
