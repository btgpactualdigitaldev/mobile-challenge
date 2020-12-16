//
//  ConversorAPI.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/14/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

enum ConversorApi {
    case liveQuota
    case list
}

extension ConversorApi: Target {
    
    ///This key was not supposed to be here, It is not safe. But for the sake of simplicity and only for this interview Project.
    var accessKey: String {
        return "82d6b1022483bae5bbff6709f74bd43a"
    }
    
    var baseURL: URL {
        return URL(staticString: "http://api.currencylayer.com")
    }
    
    var path: String {
        switch self {
        case .liveQuota:
            return "/live"
        case .list:
            return "/list"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        let header: [String: String] = ["Content-Type": "application/json"]
        return header
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var queryItems: [String : String] {
        let itens = ["access_key": accessKey]        
        return itens
    }
    
}
