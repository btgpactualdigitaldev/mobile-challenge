//
//  Network.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

import Foundation

class Network: Networking {
    
    // MARK: - Protocol Networking Implementation
    func execute<T: Decodable>(requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = requestProvider.urlRequest
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        do {
                            if ((requestProvider as? Endpoint) != nil) {
                                let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>

                                guard let success = json["success"] as? Bool, success else {
                                    if let error = json["error"] as? [String: AnyObject], let errorCode = error["code"] as? Int {
                                        completion(.failure("Contact support! \ncode: \(errorCode)"))
                                        return
                                    }
                                    completion(.failure("Contact support! \ncode: NT1"))
                                    return
                                }
                            }
                            if let decodedObject = try? JSONDecoder().decode(T.self, from: data) {
                                UserDefaults.standard.set(data, forKey: "\(T.self)")
                                completion(.success(decodedObject))
                            }
                        } catch {
                            completion(.failure("Contact support! \ncode: NT2"))
                        }
                    }
                default:
                    completion(.failure(StringsDictionary.errorContactSupport))
                }
            }
        }.resume()
    }
}

// MARK: - Networking Protocol
protocol Networking {
    func execute<T: Decodable>(requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void)
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
