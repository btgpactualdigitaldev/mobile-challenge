//
//  StorageManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

protocol StorageManager {
    associatedtype DataType
    func save(_ data: DataType)
    func get() -> DataType
    func delete(data: DataType)
    func clear()
}

extension StorageManager {
    func delete(data: DataType) { }
}
