//
//  Storage.swift
//  Storage
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Models
import Service

public protocol Storage {
    func write(_ currencies: [Currency]) -> AnyPublisher<[Currency], StorageError>
    func read() -> AnyPublisher<[Row<Currency>], StorageError>
    func write(_ quotas: [Quote]) -> AnyPublisher<[Quote], StorageError>
    func read() -> AnyPublisher<[Row<Quote>], StorageError>
}

public struct Row<Model> {
    public let model: Model
    public let updatedAt: Date
    
    public init(model: Model, updatedAt: Date) {
        self.model = model
        self.updatedAt = updatedAt
    }
}

public enum StorageError: Error, CustomStringConvertible {
    case connectionCreation(Error)
    case tableCreation(Error)
    case insertion(Error)
    case selection(Error)
    case unknown(Error)
    
    public var description: String {
        switch self {
        case .connectionCreation(let error): return "Connection creation: \(error)"
        case .tableCreation(let error): return "Table creation: \(error)"
        case .insertion(let error): return "Insertion: \(error)"
        case .selection(let error): return "Selection: \(error)"
        case .unknown(let error): return "Unknown: \(error)"
        }
    }
}
