//
//  Currencies.swift
//  DesafioBTG
//
//  Created by Any Ambria on 12/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation

struct Currencies: Codable {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let currencies: [String: String]?
    let error: Error?
}

struct Error: Codable {
    let code: Int
    let info: String
}
