//
//  MockUserDefaults.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

class MockUserDefaults: UserDefaultsProtocol {
    func getString(key: UserDefaultKey) -> String? {
        return nil
    }
    
    func getDate(key: UserDefaultKey) -> Date? {
        return nil
    }
    
    func putString(key: UserDefaultKey, value: String) {
        // Do nothing
    }
    
    func putDate(key: UserDefaultKey, value: Date) {
        // Do nothing
    }
}

class UserDefaultsReturning : MockUserDefaults {
    let mockedDate: Date
    init(mockedDate: Date) {
        self.mockedDate = mockedDate
    }
    override func getDate(key: UserDefaultKey) -> Date? {
        return mockedDate
    }
}
