//
//  List.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

// Model

struct Live: Codable {
    let code: String
    let quote: Double
}

typealias Lives = [Live]

// Helpers

extension Lives {

    init(quotes: [String: Double]) {
        self.init()
        quotes.forEach {
            CommonData.shared.lives.append(.init(code: $0.key, quote: $0.value))
        }
    }

    func save() {
        CommonData.shared.lists.removeAll()
        forEach { CommonData.shared.lives.append($0) }
    }

    func finOne(by code: String) -> Live? {
        first { $0.code == code }
    }
}
