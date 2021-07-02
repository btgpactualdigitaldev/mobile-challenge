//
//  APIClient.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import Foundation

struct APIClient: Networking {
    static let shared = APIClient()

    private init() {}

    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                               completion: @escaping (Result<T, Error>) -> Void) {

        let urlRequest = requestProviding.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkingError.noDataReceived))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkingError.invalidData))
            }
        }.resume()
    }
}
