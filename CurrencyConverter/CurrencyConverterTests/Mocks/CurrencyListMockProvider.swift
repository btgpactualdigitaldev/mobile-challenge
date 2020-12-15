//
//  MockURLSessionProvider.swift
//  CurrencyConverterTests
//
//  Created by Italo Boss on 14/12/20.
//

import XCTest
@testable import CurrencyConverter

class CurrencyListMockProvider: Provider {
    
    var mockData: Data? = {
        return """
        {
            "success": true,
            "terms": "https://currencylayer.com/terms",
            "privacy": "https://currencylayer.com/privacy",
            "currencies": {
                "BRL": "Brazilian Real",
                "USD": "United States Dollar"
            }
        }
        """.data(using: .utf8)
    }()
    
    func request<T>(type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let mockData = mockData else {
            completion(.failure(NetworkError.noJSONData))
            return
        }
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: mockData)
            completion(.success(model))
        } catch {
            completion(.failure(NetworkError.parsedData))
        }
    }
    
}
