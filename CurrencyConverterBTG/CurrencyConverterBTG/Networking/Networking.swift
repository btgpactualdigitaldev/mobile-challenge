//
//  Networking.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 25/03/21.
//

import Foundation

enum NetworkingError: String, Error {
    case transportError = "Unable to get data from server"
    case serverSideError = "There was an error on the server side"
    case clientSideError = "There was an error on the client side"
    case untreatedCodeError = "Untreated status code"
    case invalidData = "Invalid data on response"
    case decodingError = "Unable do decode data"
}

class Networking {
    
    static func request<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        guard let url = URL(string: url) else {
            preconditionFailure("Unable to construct URL")
        }
        
        Debugger.log("OUTGOING: ",url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                Debugger.log(error)
                completion(.failure(NetworkingError.transportError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                preconditionFailure("Response isn't HTTP. Only HTTP supported")
            }
            
            guard httpResponse.statusCode.isBetween(v1: 200, v2: 299) else {
                if httpResponse.statusCode.isBetween(v1: 400, v2: 499) {
                    completion(.failure(NetworkingError.clientSideError))
                } else if httpResponse.statusCode.isBetween(v1: 500, v2: 599) {
                    completion(.failure(NetworkingError.serverSideError))
                } else {
                    Debugger.warning(NetworkingError.untreatedCodeError.rawValue + " \(httpResponse.statusCode)")
                    completion(.failure(NetworkingError.untreatedCodeError))
                }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(T.self, from: data)
                    completion(.success(decodedValue))
                } catch {
                    Debugger.log(error)
                    completion(.failure(NetworkingError.decodingError))
                }
            } else {
                Debugger.log(NetworkingError.invalidData.rawValue)
                completion(.failure(NetworkingError.invalidData))
            }
        }.resume()
    }
}
