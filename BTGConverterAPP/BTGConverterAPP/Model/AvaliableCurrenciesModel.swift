//
//  ListAvaliableQuotesModel.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

struct AvaliableCurrencies: Decodable, Hashable {
        let success: Bool
        let terms: URL
        let privacy: URL
        let currencies: [String : String]
}
