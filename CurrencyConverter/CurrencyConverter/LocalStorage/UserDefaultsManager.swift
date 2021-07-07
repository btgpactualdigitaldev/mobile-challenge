//
//  UserDefaultsManager.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

class UserDefaultsManager {
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    
    
    // MARK: - Storage Methods
    func saveObject<T: Encodable>(_ object: T, forKey: String) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: forKey)
        } catch {
            throw UserDefaultsManagerError.unableToEncode
        }
    }
    
    func getObject<T: Decodable>(forKey: String, castTo type: T.Type) throws -> T {
        guard let savedData = userDefaults.object(forKey: forKey) as? Data else {
            throw UserDefaultsManagerError.noValue
        }
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: savedData)
            return object
        } catch {
            throw UserDefaultsManagerError.unableToDecode
        }
    }
}
