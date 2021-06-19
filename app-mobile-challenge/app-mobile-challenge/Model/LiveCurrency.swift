//
//  LiveCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

// Model

struct LiveCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var timestamp: Int
    public var source: String
    public var quotes: [String: Double]
}

// Helpers

extension LiveCurrency {
    static func getFromWeb(completion: @escaping ResultHandler<Lives>) {
        DispatchQueue.main.async {
            var publishers = [AnyCancellable]()
            CurrencyApi.shared.lives
                .map { $0 }
                .sink(
                    receiveCompletion: { error in
                        if case let .failure(error) = error  {
                            completion(.failure(error))
                        }
                    },
                    receiveValue: {
                        completion(.success(.init(quotes: $0.quotes)))
                    }
                )
                .store(in: &publishers)
            RunLoop.main.run(until: .init(timeIntervalSinceNow: 2))
            withExtendedLifetime(publishers, {})
        }
    }
}
