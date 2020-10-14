//
//  ListRequest.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

struct ListRequest: APIRequest {
    var path: String {
        return "/list"
    }
    
    var mockPath: String {
        return ""
    }
    
    typealias Response = CurrencyList
}
