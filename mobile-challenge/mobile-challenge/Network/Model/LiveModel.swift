//
//  LiveModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Struct used to decode API response (/live) with currencies exchange values in relation to USD
struct LiveModel: DataModelProtocol {
    static let service: ServiceType = .live
    
    let success: Bool
    let error: ErrorDataModel?
    let timestamp: Double
    let quotes: [String:Double]?
}
