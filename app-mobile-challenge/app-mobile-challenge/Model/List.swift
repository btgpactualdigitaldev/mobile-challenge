//
//  Currency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

// Model

struct List: Codable {
    let code: String
    let name: String
    var favorite: Bool = false
    
    func saveFavorite() {
        if favorite {
            CommonData.shared.favorites.append(code)
        } else {
            if let index = CommonData.shared.favorites.firstIndex(where: {$0 == code}) {
                CommonData.shared.favorites.removeFirst(index)
            }
        }
    }
}

typealias Lists = [List]

// Helpers

extension Lists {
    init(currencies: [String: String]) {
        self.init()
        currencies.forEach { currency in
            append(.init(code: currency.key, name: currency.value))
        }
    }

    func save() {
        CommonData.shared.lists.removeAll()
        forEach { CommonData.shared.lists.append($0) }
    }

    func finOne(by code: String) -> List? {
        first { $0.code == code }
    }
}
