//
//  LocalPreferencesDataBase.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation


class LocalPreferencesDataBase {
    
    let defaults = UserDefaults.standard
    
    static let shared = LocalPreferencesDataBase()
    
    func save<T: Codable>(model: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            defaults.set(encoded, forKey: "\(T.self)")
        }
    }
    
    func find<T: Codable>()-> T? {
        if let savedPerson = defaults.object(forKey: "\(T.self)") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(T.self, from: savedPerson) {
                return loadedPerson
            }
        }
        
        return nil
    }
}
