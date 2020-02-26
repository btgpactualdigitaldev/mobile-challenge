//
//  StoreDelegates.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Foundation

protocol ConversionStore: GenericStore {
    func getQuotes(parameters: [String: Any], completion: @escaping completion<Conversion.Quotes.Response?>)
}

protocol CoinListingStore: GenericStore {
    func getCurrencies(completion: @escaping completion<CoinListing.Currencies.Response?>)
}
