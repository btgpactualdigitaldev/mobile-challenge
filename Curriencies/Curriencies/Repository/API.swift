//
//  API.swift
//  Curriencies
//
//  Created by Ferraz on 02/09/21.
//

import Foundation

protocol NetworkSession {
    func loadData(url: URL,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(url: URL,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { data, urlResponse, error in
            completion(data, urlResponse, error)
        }
        task.resume()
    }
}

final class API {
    let networkSession: NetworkSession

    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
}

extension API: Repository {
    func fetch<T:Decodable>(endpoint: String,
                            completion: @escaping (Result<T, RepositoryError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.urlUnknown))
            return
        }

        networkSession.loadData(url: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decoderError))
                return
            }

            completion(.success(value))
        }
    }
}
