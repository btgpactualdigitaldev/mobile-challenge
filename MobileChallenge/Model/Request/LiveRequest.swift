//
//  LiveRequest.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

struct LiveRequest: APIRequest {    
    var path: String {
        return "/live"
    }
    
    var mockPath: String {
        return ""
    }
    
    typealias Response = CurrencyLive
}
