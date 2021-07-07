//
//  DataManagerMock.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import Foundation

struct DataManagerMock<T>: DataManager {
    
    var returnError: Error? = nil
    var returnData: T?
    
    func request(_ request: CurrencyConverterRequests, completion: @escaping (T?, Error?) -> ()) {
        if returnError == nil {
            completion(returnData, nil)
        } else {
            completion(nil, returnError)
        }
    }
}
