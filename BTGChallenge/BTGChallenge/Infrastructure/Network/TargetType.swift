//
//  TargetTypr.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 11/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya

enum Paths: String {
    case convert = "convert"
    case list = "/list"
    case live = "live"
}

enum Keys: String {
    case accessKey = "access_key"
    case from = "from"
    case to = "to"
    case amount = "amount"
    case format = "format"
    case currencies = "currencies"
    case source = "source"
}

enum Values: String {
    case ApiKey = "6190773cbb091b870662e08d6ff32144"
}

extension TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://api.currencylayer.com/")!
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return ["":""]
    }
}
