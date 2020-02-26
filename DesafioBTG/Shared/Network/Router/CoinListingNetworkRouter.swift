//
//  CoinListingNetworkRouter.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Foundation

enum CoinListingNetworkRouter {
    
    case list
    
    var path: String {
        switch self {
        case .list:
            return API.list
        }
    }
    
    func asURLRequest() throws -> URL? {
        guard let url = URL(string: API.URL) else { return nil }
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        switch self {
        case .list:
            return urlRequest.url
        }
    }
    
}
