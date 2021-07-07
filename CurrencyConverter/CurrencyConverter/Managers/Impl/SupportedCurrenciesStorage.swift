//
//  SupportedCurrenciesStorage.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation
import CoreData

struct SupportedCurrenciesStorage: StorageManager {
    typealias DataType = SupportedCurrencies
    
    func save(_ data: SupportedCurrencies) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        if let obj = NSEntityDescription.insertNewObject(forEntityName: "CoreDataSupportedCurrencies", into: context) as? CoreDataSupportedCurrencies {
            obj.currencies = data.currencies as NSObject
        }
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func get() -> SupportedCurrencies {
        let context:NSManagedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetch = CoreDataSupportedCurrencies.supportedCurrenciesFetchRequest()
        
        do {
            let result:[CoreDataSupportedCurrencies] = try context.fetch(fetch)
            if let currencies = result.first {
                let supportedCurrencies = SupportedCurrencies(withCoreDataObj: currencies)
                return supportedCurrencies
            }
            
            return SupportedCurrencies(success: false, currencies: [:])
        } catch {
            return SupportedCurrencies(success: false, currencies: [:])
        }
    }
    
    func clear() {
        
    }
}
