//
//  HttpClient.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

protocol CurrencyLayerResponse: Codable {
    var success: Bool { get }
}

class HttpClient {
    private let baseUrl = URL(string: "http://api.currencylayer.com/")
    private let access_key = "3a57eb54fa448a9c2e2fc36c44b9f4e8"
    
    enum HttpError: Error {
        case InvalidURL
        case ServerError
        case InvalidResponse
    }
    
    func request<T: CurrencyLayerResponse>(method: String, completion: @escaping (Result<T, HttpError>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(method), var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let queryItems = [URLQueryItem(name: "access_key", value: access_key)]
        urlComponents.queryItems = queryItems
        
        URLSession.shared.dataTask(with: urlComponents.url!) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 300 else {
                    inMainThread {
                        completion(.failure(.ServerError))
                    }
                    return
                }
                
                do {
                    let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                    if jsonResponse.success {
                        inMainThread {
                            completion(.success(jsonResponse))
                        }
                    } else {
                        print(jsonResponse)
                        inMainThread {
                            completion(.failure(.ServerError))
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    inMainThread {
                        completion(.failure(.InvalidResponse))
                    }
                }
            case .failure(_):
                inMainThread {
                    completion(.failure(.ServerError))
                }
            }
        }.resume()
    }
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
