//
//  HomeService.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation
import Combine

public class HomeService {
    public func fetchLive(fromCurrency input: Currency, toCurrencyCode output: String) -> AnyPublisher<Decimal, ServiceError> {
        Network(Endpoints.live.url)
            .request(LiveDTO.self)
            .tryMap { liveDTO in
                guard let quotes = liveDTO.quotes, !quotes.isEmpty else {
                    throw ServiceError.isEmpty
                }
                guard let outputQuote = quotes["USD"+output], let inputQuote = quotes["USD"+input.code] else {
                    throw ServiceError.missingCurrency
                }
                
                let inputValue = input.value
                let outputValue = inputValue / inputQuote * outputQuote
                
                return outputValue
            }
            .mapError { error in
                switch error {
                case is URLError:
                    return .sessionFailed
                case ServiceError.isEmpty:
                    return .isEmpty
                case ServiceError.missingCurrency:
                    return .missingCurrency
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
