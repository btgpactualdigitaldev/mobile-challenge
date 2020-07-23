//
//  ServiceRequest.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - ServiceRequest
final class ServiceRequest {
    static let shared: ServiceManagerProtocol = ServiceManager()
}
