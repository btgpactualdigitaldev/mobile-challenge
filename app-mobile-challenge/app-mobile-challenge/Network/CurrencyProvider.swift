//
//  CurrencyFactProvider.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Combine

// Enums

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

// Protocols

protocol CurrencyProvider {
    var lists: AnyPublisher<ListCurrency, APIError> { get }
    var lives: AnyPublisher<LiveCurrency, APIError> { get }
}

// Alias

typealias ResultHandler<T> = (Result<T, APIError>) -> Void
