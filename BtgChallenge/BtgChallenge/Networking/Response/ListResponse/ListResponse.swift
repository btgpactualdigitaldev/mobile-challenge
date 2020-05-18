//
//  ListResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 15/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct ListResponse: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var currencies: CurrenciesResponse?
}
