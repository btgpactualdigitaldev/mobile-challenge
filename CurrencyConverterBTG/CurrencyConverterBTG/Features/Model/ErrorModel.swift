//
//  ErrorModel.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    let code: Int
    let type: String
    let info: String
}
