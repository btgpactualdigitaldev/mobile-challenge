//
//  HTTPRouter.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 12/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol HTTPRouter {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String] { get }
    var headers: [String: String]? { get }
}
