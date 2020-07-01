//
//  ErrorModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    let code: Int
    let type: String
    let info: String
}
