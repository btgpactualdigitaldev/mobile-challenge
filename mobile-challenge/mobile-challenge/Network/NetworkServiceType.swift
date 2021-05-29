//
//  NetworkServiceType.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

enum NetworkServiceType {
    case list
    case live
}

extension NetworkServiceType: NetworkRequestProtocol {
    var host: String {
        return "http://api.currencylayer.com/"
    }
    
    var accessKey: String {
        return "access_key=ec2719e60e343d28f7bad8ce4bdf10f6"
    }
    
    var path : String {
        switch self {
        case .list:
            return "\(host)list?\(accessKey)"
        case .live:
            return "\(host)live?\(accessKey)"
        }
    }
    
}
