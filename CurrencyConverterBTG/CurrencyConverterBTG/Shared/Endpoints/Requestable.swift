//
//  Requestable.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

protocol Requestable {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var customBody: Data? { get }
}
