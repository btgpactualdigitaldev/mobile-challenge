//
//  ErrorResponse.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

struct ErrorResponse: Decodable {
    let code: Int
    let type: String
    let info: String
}
