//
//  ConversionNetworkRouter.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 19/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Foundation

enum ConversionNetworkRouter {
    
    case live
    
    var path: String {
        switch self {
        case .live:
            return API.live
        }
    }
    
    func asURLRequest() throws -> URL? {
        guard let url = URL(string: API.URL) else { return nil }
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        switch self {
        case .live:
            return urlRequest.url
        }
    }
    
}
