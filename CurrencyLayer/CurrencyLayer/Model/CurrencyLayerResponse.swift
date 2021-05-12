//
//  CurrencyLayerResponse.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 08/12/20.
//

import Foundation

public struct CurrencyLayerResponse: Decodable {
  var quotes: [String:Double]
}

