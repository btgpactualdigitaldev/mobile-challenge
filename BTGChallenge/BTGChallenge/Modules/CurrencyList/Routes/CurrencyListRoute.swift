//
//  CurrencyListRoute.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
import Moya

enum CurrencyListRoute {
    case list
}

extension CurrencyListRoute: TargetType {
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var path: String {
        return Paths.list.rawValue
    }
}
