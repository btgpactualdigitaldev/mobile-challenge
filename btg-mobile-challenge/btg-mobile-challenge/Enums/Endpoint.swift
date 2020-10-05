//
//  Endpoint.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// Endpoints available.
enum Endpoint: String {
    // - MARK: Cases
    /// Endpoint for live rates.
    case live = "live?"
    /// Endpoint for supported currencies.
    case list = "list?"
}

// - MARK: Extension
extension Endpoint {
    /// The private API key.
    /// It shouldn't be pushed to remote.
    private var accessKey: String {
        return "access_key=d96d3074cd7cc555c2d3dff3944c855e"
    }

    /// The base API URL.
    private var base: String {
        return "http://api.currencylayer.com/"
    }

    //- MARK: URL
    /// Computed variable responsible for building eache endpoint's URL.
    var url: URL? {
        switch self {
        case .live:
            guard let url = URL(string: "\(base)\(Endpoint.live.rawValue)\(accessKey)") else {
                return nil
            }
            return url
        case .list:
            guard let url = URL(string: "\(base)\(Endpoint.list.rawValue)\(accessKey)") else {
                return nil
            }
            return url
        }
    }
}
