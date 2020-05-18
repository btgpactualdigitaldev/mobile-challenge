//
//  ConvertResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct ConvertResponse: Codable {
    let success: Bool
    let terms, privacy: String
    let query: QueryResponse
    let info: InfoResponse
    let result: Double
}
