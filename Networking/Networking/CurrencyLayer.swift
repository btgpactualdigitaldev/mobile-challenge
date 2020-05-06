//
//  CurrencyLayer.swift
//  Networking
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Models
import Combine

public enum CurrencyLayer {
    
    struct SupportedCurrencies: Decodable, Hashable {
        let success: Bool
        let terms: URL
        let privacy: URL
        let currencies: [String : String]
    }
    
    struct RealTimeRates: Decodable, Hashable {
        let success: Bool
        let terms: URL
        let privacy: URL
        let timestamp: Date
        let source: String
        let quotes: [String : Double]
    }
}

extension Requester {
    public func supportedCurrencies(_ bundle: Bundle = .main) -> AnyPublisher<[Currency], RequestError> {
        let parameters = [ "access_key": Endpoint.apiKey(bundle) ]
        return get(from: .supportedCurrencies(bundle), queryParameters: parameters, decoder: JSONDecoder())
            .map { (decodedResponse: RequestDecodedResponse<CurrencyLayer.SupportedCurrencies>) -> [Currency] in
                decodedResponse.data.currencies.map { Currency(abbreviation: $0.key, fullName: $0.value) }
        }.eraseToAnyPublisher()
    }

    public func realTimeRates(_ bundle: Bundle = .main) -> AnyPublisher<[Quote], RequestError> {
        let parameters = [ "access_key": Endpoint.apiKey(bundle) ]
        return get(from: .realTimeRates(bundle), queryParameters: parameters, decoder: JSONDecoder())
            .map { (decodedResponse: RequestDecodedResponse<CurrencyLayer.RealTimeRates>) -> [Quote] in
                decodedResponse.data.quotes.map { quote in
                    let pivo = quote.key.index(quote.key.startIndex, offsetBy: 3)
                    let first = quote.key[..<pivo]
                    let second = quote.key[pivo...]
                    return Quote(String(first), String(second), quote.value)
                }
            }.eraseToAnyPublisher()
    }
}


