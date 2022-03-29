//
//  ConnectionLive.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit
import NetworkCore

struct ConnectionLive: ConnectionProtocol {
    var headers: [String : String]?
    
    var baseUrl: URL
    
    var port: String?
    
    var router: String
    
    var method: String?
    
    var components: [String : String]?
    
    var parameters: [String : Any]?
    
    
    init() {
        baseUrl = URL(string: "https://btg-mobile-challenge.herokuapp.com/") ?? URL(fileURLWithPath: "")
        router = "live"
    }
}
