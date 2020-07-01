//
//  Requestable.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 27/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

protocol Requestable {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var customBody: Data? { get }
}
