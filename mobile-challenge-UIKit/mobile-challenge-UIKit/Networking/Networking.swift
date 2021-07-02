//
//  Networking.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol Networking {
    /// Execute an API request (GET or POST)
    /// - Parameters:
    ///   - requestProviding: a RequestProviding conforming object
    ///   - completion: closure to inform changes
    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                             completion: @escaping (Result<T, Error>) -> Void)
}
