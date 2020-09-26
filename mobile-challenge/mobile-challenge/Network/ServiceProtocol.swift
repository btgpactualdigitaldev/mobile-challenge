//
//  ServiceProtocol.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

protocol ServiceProtocol {
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: [String:String]? { get }
    var headers: [String:String]? { get }
}

enum HttpMethod: String {
    case get
    
    var value: String {
        self.rawValue.uppercased()
    }
}
