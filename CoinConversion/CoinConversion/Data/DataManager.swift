//
//  DataManager.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 22/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import CoreData

protocol DataManagerDelegate: class {
    func didDataManagerFail(with reason: String)
}

// MARK: Main
class DataManager: NSObject {
    
    weak var delegate: DataManagerDelegate?
    private var coreDataStack = CoreDataStack.shared
    
    var viewContext: NSManagedObjectContext {
        return coreDataStack.persistentContainer.viewContext
    }
    
    private func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                viewContext.delete(objectData)
            }
        } catch {
            delegate?.didDataManagerFail(with: "Ao Deletar \(entity) ocorreu um error." )
        }
    }
}

// MARK: DatabaseQuotes
extension DataManager {
    func syncQuotes(with conversionCurrencies: ConversionModel) {
        self.deleteAllData("ConversionEntity")
        self.savingQuotes(with: conversionCurrencies)
    }
    
    func hasDatabaseQuotes() -> Bool {
        let conversionRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ConversionEntity")
        do {
            let conversionResult = try viewContext.fetch(conversionRequest) as? [ConversionEntity]
            if conversionResult?.count ?? 0 > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("error \(error), \(error.userInfo)")
            delegate?.didDataManagerFail(with: "\(error.userInfo)" )
            return false
        }
    }
    
    func fetchDatabaseQuotes() -> ConversionModel? {
        var conversion: [ConversionCurrenciesModel] = []
        let quotesEntity = NSFetchRequest<NSFetchRequestResult>(entityName: "ConversionEntity")
        
        do {
            let quotesData = try viewContext.fetch(quotesEntity) as? [ConversionEntity]
            guard let objectData = quotesData else { return nil }
            
            for data in objectData {
                conversion.append(
                    ConversionCurrenciesModel(code: data.code ?? "", quotes: data.quotes)
                )
            }
            return ConversionModel(date: objectData.first!.timestamp, conversion: conversion)
        } catch {
            return nil
        }
    }
    
    private func savingQuotes(with conversionCurrencies: ConversionModel) {
        if let quotesEntity = NSEntityDescription.entity(forEntityName: "ConversionEntity", in: viewContext) {
            
            conversionCurrencies.conversion?.forEach { conversionQuotes in
                
                let conversion = NSManagedObject(entity: quotesEntity, insertInto: viewContext)
                conversion.setValue(conversionQuotes.code, forKeyPath: "code")
                conversion.setValue(conversionQuotes.quotes, forKey: "quotes")
                conversion.setValue(conversionCurrencies.date, forKey: "timestamp")
                
            }
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                delegate?.didDataManagerFail(with: "\(error.userInfo)" )
            }
        }
    }
}

// MARK: DatabaseListCurrencies
extension DataManager {
    func syncListCurrencies(currencies: [ListCurrenciesModel]) {
        self.deleteAllData("CurrenciesEntity")
        self.savingListCurrencies(with: currencies)
    }
    
    func hasDatabaseListCurrencies() -> Bool {
        let currenciesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrenciesEntity")
        do {
            let currenciesResult = try viewContext.fetch(currenciesRequest) as? [CurrenciesEntity]
            if currenciesResult?.count ?? 0 > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("error \(error), \(error.userInfo)")
            delegate?.didDataManagerFail(with: "\(error.userInfo)" )
            return false
        }
    }
    
    func fetchDatabaseListCurrencies() -> [ListCurrenciesModel]? {
        var listCurrencies: [ListCurrenciesModel] = []
        let currenciesEntity = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrenciesEntity")
        
        do {
            let currenciesData = try viewContext.fetch(currenciesEntity) as? [CurrenciesEntity]
            guard let objectData = currenciesData else { return nil }
            
            for data in objectData {
                listCurrencies.append(
                    ListCurrenciesModel(name: data.name ?? "", code: data.code ?? "")
                )
            }
            return listCurrencies
        } catch {
            return nil
        }
    }
    
    private func savingListCurrencies(with currencies: [ListCurrenciesModel]) {
        if let currenciesEntity = NSEntityDescription.entity(forEntityName: "CurrenciesEntity", in: viewContext) {
            
            currencies.forEach { conversionQuotes in
                
                let conversion = NSManagedObject(entity: currenciesEntity, insertInto: viewContext)
                conversion.setValue(conversionQuotes.code, forKeyPath: "code")
                conversion.setValue(conversionQuotes.name, forKey: "name")
                
            }
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                delegate?.didDataManagerFail(with: "\(error.userInfo)" )
            }
        }
    }
}
