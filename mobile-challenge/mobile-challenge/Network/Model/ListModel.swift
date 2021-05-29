//
//  ListModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Struct used to decode API response (/list) with currencies code and name
struct ListModel: DataModelProtocol {
    static let service: ServiceType = .list
    
    let success: Bool
    let error: ErrorDataModel?
    let currencies: [String:String]?
}
