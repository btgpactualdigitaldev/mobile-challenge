//
//  CurrencyLayerApi.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum CurrencyLayerApi {
    case getRate(currencies: String)
    case list
}

extension CurrencyLayerApi: TargetType {
    var baseURL: URL {
        return URL(string: Constants.currencyLayerApiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .getRate:
            return "/live"
        case .list:
            return "/list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRate, .list:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRate(let currencies):
            var parameters: [String: Any] = [:]
            parameters["access_key"] = Constants.currencyLayerApiKei
            parameters["currencies"] = currencies
            parameters["format"] = "1"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        default:
            var parameters: [String: Any] = [:]
            parameters["access_key"] = Constants.currencyLayerApiKei
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getRate, .list:
            return ["content-type": "application/json"]
        }
    }
}
