//
//  ModelError.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

struct ModelError: Codable {
    let code: Int?
    let type: String?
    let info: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case type = "type"
        case info = "info"
    }
}
