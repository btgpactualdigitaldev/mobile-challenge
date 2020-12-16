//
//  Target.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum Task {
    case requestPlain
}

protocol Target {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var task: Task { get }
    var queryItems: [String: String] { get }
}
