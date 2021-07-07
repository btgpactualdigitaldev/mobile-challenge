//
//  ExchangeRatesStorage.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation
import CoreData

struct ExchangeRatesStorage: StorageManager {
    typealias DataType = ExchangeRates
    
    func save(_ data: ExchangeRates) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        if let obj = NSEntityDescription.insertNewObject(forEntityName: "CoreDataExchangeRates", into: context) as? CoreDataExchangeRates {
            obj.source = data.source
            obj.quotes = data.quotes as NSObject
        }
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func get() -> ExchangeRates {
        let context:NSManagedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetch = CoreDataExchangeRates.exchangeRatesFetchRequest()
        
        do {
            let result:[CoreDataExchangeRates] = try context.fetch(fetch)
            if let coreDataExchageRates = result.first {
                let exchangeRates = ExchangeRates(withCoreDataObj: coreDataExchageRates)
                return exchangeRates
            }
            return ExchangeRates(success: false, source: "", timestamp: 0, quotes: [:])
        } catch {
            return ExchangeRates(success: false, source: "", timestamp: 0, quotes: [:])
        }
    }
    
    func clear() {
        
    }
}
