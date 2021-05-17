//
//  NetworkMock.swift
//  XCurrencyTests
//
//  Created by Vinicius Nadin on 01/04/21.
//

import XCTest
@testable import XCurrency

class NetworkMock<V: Encodable>: Networking {

    // MARK: - Attributes
    var data: DataMock<V>

    // MARK: - Initializer
    init(data: DataMock<V>) {
        self.data = data
    }

    // MARK: - Public Methods
    func execute<T>(requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do {
            let data = try encoder.encode(self.data)
            let object = try decoder.decode(T.self, from: data)
            completion(.success(object))
        } catch {
            completion(.failure("ERROR"))
        }
    }
}

typealias DataMock<V: Encodable> = [String: [String: V]]

