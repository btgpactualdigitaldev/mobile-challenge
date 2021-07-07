//
//  NetworkManagerProtocol.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

protocol NetworkManagerProtocol {
    func get<T: Decodable>(baseURL: String, parameters: [String: String]?, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}
