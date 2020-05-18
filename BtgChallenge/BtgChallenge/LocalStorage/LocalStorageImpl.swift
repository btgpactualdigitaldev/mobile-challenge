//
//  LocalStorageImpl.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 16/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

class LocalStorageImpl: LocalStorage {
    
    // MARK: - Constants
    static let liveKey = "LiveResponse"
    
    // MARK: - Properties
    
    let userDefaults: UserDefaults
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func setLiveCache(liveResponse: LiveResponse) {
        if let cachedResponse: LiveResponse = getCachedObject() {
            cachedResponse.quotes?.forEach { element in
                if liveResponse.quotes?[element.key] == nil {
                    liveResponse.quotes?[element.key] = element.value
                }
            }
        }
        
        save(object: liveResponse)
    }
    
    func setListCache(listResponse: ListResponse) {
        save(object: listResponse)
    }
    
    func getCachedObject<T: Decodable>() -> T? {
        if let object  = userDefaults.data(forKey: T.className) {
            let decodedObject = try? decoder.decode(T.self, from: object)
            
            return decodedObject
        }
        
        return nil
    }
    
    fileprivate func save<T: Codable>(object: T) {
        if let encodedData = try? encoder.encode(object) {
            userDefaults.set(encodedData, forKey: T.className)
        }
    }
}

extension Decodable {
    static var className: String {
        return String(describing: type(of: self))
    }
}
