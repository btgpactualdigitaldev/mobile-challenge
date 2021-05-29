//
//  ErrorDataModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Struct used to decode API error response
struct ErrorDataModel: Decodable {
    let code: Int
    let info: String
}
