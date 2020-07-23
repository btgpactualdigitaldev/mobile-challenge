//
//  ServiceManagerProtocol.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - ServiceManagerProtocol
protocol ServiceManagerProtocol {
    func request(method: ServiceHTTPMethod,
                 url: String, parameters: [String: Any]?,
                 encoding: ServiceEncoding,
                 success: @escaping (Data) -> Void,
                 failure: @escaping ((_ responseError: ServiceError)->()) )
}
