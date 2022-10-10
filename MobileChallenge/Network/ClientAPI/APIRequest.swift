//
//  APIRequest.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

public protocol APIRequest: Encodable {
    
    var path: String { get }
    var mockPath: String { get }
    
    associatedtype Response: APIResponse
}
