//
//  ListCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

// Model

struct ListCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var currencies: [String: String]
}

// Helpers

extension ListCurrency {
    static func getFromWeb(completion: @escaping ResultHandler<Lists>) {
        DispatchQueue.main.async {
            var publishers = [AnyCancellable]()
            CurrencyApi.shared.lists
                .map { $0 }
                .sink(
                    receiveCompletion: { error in
                        if case let .failure(error) = error  {
                            completion(.failure(error))
                        }
                    },
                    receiveValue: {
                        completion(.success(.init(currencies: $0.currencies)))
                    }
                )
                .store(in: &publishers)
            RunLoop.main.run(until: .init(timeIntervalSinceNow: 2))
            withExtendedLifetime(publishers, {})
        }
    }
}
