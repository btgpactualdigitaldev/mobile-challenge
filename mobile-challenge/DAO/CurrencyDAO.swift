//
//  CurrencyDAO.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 27/09/20.
//

import CoreData

class CurrencyDAO {
    let userDefaults: UserDefaults
    init() {
        userDefaults = UserDefaults.standard
    }
    
    func save(currencies: [CurrencyModel], dateExchange: Date) {
        do {
            let data = try self.archive(objects: currencies)
            let date = dateExchange.timeIntervalSince1970
            self.userDefaults.set(data, forKey: CurrencyModel.uniqueIdentifier)
            self.userDefaults.set(date, forKey: Identifier.UserDefaultKey.date.rawValue)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> ([CurrencyModel], Date) {
        var currencies: [CurrencyModel] = []
        var date = Date()
        do {
            if let data = userDefaults.data(forKey: CurrencyModel.uniqueIdentifier){
                if let savedCurrencies = try unarchive(data: data) {
                    let savedDate = userDefaults.double(forKey: Identifier.UserDefaultKey.date.rawValue)
                    currencies = savedCurrencies
                    date = Date(timeIntervalSince1970: savedDate)
                }
            }
        } catch {
            print(error)
        }
        return (currencies, date)
    }
}

extension CurrencyDAO {
    
    func archive(objects: [CurrencyModel]) throws -> Data? {
        return try NSKeyedArchiver.archivedData(withRootObject: objects, requiringSecureCoding: false)
    }
    
    func unarchive(data: Data) throws -> [CurrencyModel]? {
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CurrencyModel]
    }
    
}
