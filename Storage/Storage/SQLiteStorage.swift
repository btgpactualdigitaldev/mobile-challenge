//
//  CurrencyLayer.swift
//  Storage
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import SQLite
import Models
import Combine

public class SQLiteStorage: Storage {
    
    private let connection: AnyPublisher<Connection, StorageError>
    
    public init(_ location: Connection.Location) {
        self.connection = createConnection(location)
            .flatMap { createSchema(at: $0) }
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .eraseToAnyPublisher()
    }
    
    public func write(_ currencies: [Currency]) -> AnyPublisher<[Currency], StorageError> {
        return connection
            .tryMap { db in
                do {
                    try currencies.forEach { currency in
                        try db.run(currenciesTable.insert(
                            or: .replace,
                            fullNameExpr <- currency.fullName,
                            abbreviationExpr <- currency.abbreviation,
                            updatedAtExpr <- Date()))
                    }
                } catch {
                    throw StorageError.insertion(error)
                }
            return currencies
        }
        .mapError { $0 as? StorageError ?? .unknown($0) }
        .eraseToAnyPublisher()
    }
    
    public func write(_ quotes: [Quote]) -> AnyPublisher<[Quote], StorageError> {
        return connection
            .tryMap { db in
                do {
                    try quotes.forEach { quote in
                        try db.run(quotesTable.insert(
                            or: .replace,
                            firstCurrencyExpr <- quote.first,
                            secondCurrencyExpr <- quote.second,
                            valueExpr <- quote.value,
                            updatedAtExpr <- Date()))
                    }
                } catch {
                    throw StorageError.insertion(error)
                }
            return quotes
        }
        .mapError { $0 as? StorageError ?? .unknown($0) }
        .eraseToAnyPublisher()
    }
    
    public func read() -> AnyPublisher<[Row<Currency>], StorageError> {
        return connection
            .tryMap { db in
                do {
                    return try db.prepare(currenciesTable).map { row -> Row<Currency> in
                        let currency = Currency(abbreviation: row[abbreviationExpr], fullName: row[fullNameExpr])
                        return Row<Currency>(model: currency, updatedAt: row[updatedAtExpr])
                    }
                } catch {
                    throw StorageError.selection(error)
                }
            }
            .mapError { $0 as? StorageError ?? .unknown($0) }
            .eraseToAnyPublisher()
    }
    
    public func read() -> AnyPublisher<[Row<Quote>], StorageError> {
         return connection
                   .tryMap { db in
                       do {
                           return try db.prepare(quotesTable).map { row -> Row<Quote> in
                               let quota = Quote(row[firstCurrencyExpr], row[secondCurrencyExpr], row[valueExpr])
                               return Row<Quote>(model: quota, updatedAt: row[updatedAtExpr])
                           }
                       } catch {
                           throw StorageError.selection(error)
                       }
                   }
                   .mapError { $0 as? StorageError ?? .unknown($0) }
                   .eraseToAnyPublisher()
    }
}

fileprivate let currenciesTable = Table("currency")
fileprivate let abbreviationExpr = Expression<String>("abbreviation")
fileprivate let fullNameExpr = Expression<String>("full_name")

fileprivate let quotesTable = Table("quote")
fileprivate let firstCurrencyExpr = Expression<String>("first_currency")
fileprivate let secondCurrencyExpr = Expression<String>("second_currency")
fileprivate let valueExpr = Expression<Double>("value")

fileprivate let updatedAtExpr = Expression<Date>("updated_at")

fileprivate func createSchema(at connection: Connection) -> AnyPublisher<Connection, StorageError> {
    
    do {
        try connection.run(currenciesTable.create(ifNotExists: true) { builder in
            builder.column(abbreviationExpr, primaryKey: true)
            builder.column(fullNameExpr)
            builder.column(updatedAtExpr)
        })
        
        try connection.run(quotesTable.create(ifNotExists: true) { builder in
            builder.column(firstCurrencyExpr)
            builder.column(secondCurrencyExpr)
            builder.column(valueExpr)
            builder.column(updatedAtExpr)
            builder.primaryKey(firstCurrencyExpr, secondCurrencyExpr)
        })
    } catch {
        return Swift.Result<Connection, StorageError>.failure(StorageError.tableCreation(error))
            .publisher
            .eraseToAnyPublisher()
    }
    
    return Swift.Result<Connection, StorageError>.success(connection)
        .publisher
        .eraseToAnyPublisher()
}

fileprivate func createConnection(_ location: Connection.Location) -> AnyPublisher<Connection, StorageError> {
    do {
        return Swift.Result<Connection, StorageError>.success(try Connection(location))
            .publisher
            .eraseToAnyPublisher()
    } catch {
        return Swift.Result<Connection, StorageError>.failure(StorageError.connectionCreation(error))
            .publisher
            .eraseToAnyPublisher()
    }
}

