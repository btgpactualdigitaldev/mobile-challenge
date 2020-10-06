//
//  ErrorApi.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation


struct ErrorApi: Codable {
    let code: Int
    let type: String
    let info: String
    
    init(code: Int, type: String, info: String) {
        self.code = code
        self.type = type
        self.info = info
    }
}
