//
//  CurrencylayerNetwork.swift
//  CurrencyServices
//
//  Created by Breno Aquino on 29/10/20.
//

import Foundation

public class CurrencylayerNetwork {
    
    private let baseUrl: String = "api.currencylayer.com"
    private let accessKey: String = "ef06b891def0317f86b874f22acf7852"
    
    // MARK: - Life Cycle
    public init() {}
    
    // MARK: - Network Calls
    public func list(callback: @escaping (Result<Dictionary<String, String>, CurrencyError>) -> Void) {
        Network.request(method: .get, baseUrl: baseUrl, path: "/list", params: ["access_key": accessKey]) { result in
            switch result {
            case .success(let dict):
                if let currencies = dict["currencies"] as? [String: String] {
                    callback(.success(currencies))
                } else {
                    callback(.failure(CurrencyError(type: .encodingError, info: "Encoding Error")))
                }
                
            case .failure(let error):
                callback(.failure(CurrencyError(error: error.error, data: error.data)))
            }
        }
    }
    
    public func values(currenciesCodes: [String], callback: @escaping (Result<(quotes: Dictionary<String, Double>, timestamp: Double), CurrencyError>) -> Void) {
        let codes = currenciesCodes.joined(separator: ",")
        Network.request(method: .get, baseUrl: baseUrl, path: "/live", params: ["currencies": codes, "access_key": accessKey]) { result in
            switch result {
            case .success(let dict):
                if let values = dict["quotes"] as? [String: Double], let timestamp = dict["timestamp"] as? Double {
                    callback(.success((values, timestamp)))
                } else {
                    callback(.failure(CurrencyError(type: .encodingError, info: "Encoding Error")))
                }
                
            case .failure(let error):
                callback(.failure(CurrencyError(error: error.error, data: error.data)))
            }
        }
    }
}
