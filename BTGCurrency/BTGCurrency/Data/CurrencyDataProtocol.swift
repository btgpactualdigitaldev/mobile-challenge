//
//  CurrencyDataProtocol.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 06/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

protocol CurrencyDataProtocol {
    func save(quotesResponse: CurrencyQuoteResponse, namesResponse: CurrencyNameResponse) -> Bool
    func getAll() -> Results<Currency>
    func get(forAbbreviation abbreviation: String) -> Currency?
}
