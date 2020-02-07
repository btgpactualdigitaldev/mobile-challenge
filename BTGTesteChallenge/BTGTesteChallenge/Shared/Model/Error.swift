//
//  Error.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

struct CurrencyError: Decodable {
    var success: Bool?
    var error: ErrorCode?
}

struct ErrorCode: Decodable {
    var code: Int?
    var info: String?
    
    enum CodingKeys: CodingKey {
        case code
        case info
    }
    
    init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        code = try decoder.decode(Int.self, forKey: .code)
        info = try decoder.decode(String.self, forKey: .info)
    }
}
