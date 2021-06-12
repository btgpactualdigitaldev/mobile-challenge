//
//  AppProvider.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 12/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

//import Moya
//import UIKit
//
// let provider = MoyaProvider<APITarget>(plugins: [NetworkLoggerPlugin(verbose: false)])
//
//enum APITarget{
//    case list
//    case convert
//    case live
//}
//
//extension APITarget: TargetType {
//    
//    var path: String {
//        switch  self {
//        case .list:
//            return Paths.list.rawValue
//        case .convert:
//            return Paths.convert.rawValue
//        case .live:
//            return Paths.list.rawValue
//        }
//    }
//    
//    var method: Method {
//        switch self {
//        case .list:
//            return .get
//        case .convert:
//            return .get
//        case .live:
//            return .get
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case .list:
//             var parameters: [String: Any] = [:]
//             parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
//             return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        case .convert:
//             var parameters: [String: Any] = [:]
//              parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
//             return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        case .live:
//             var parameters: [String: Any] = [:]
//             parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
//             return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        }
//    }
//    
//}
