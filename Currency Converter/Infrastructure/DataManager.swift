//
//  DataManager.swift
//  Currency Converter
//
//  Created by Otávio Souza on 01/10/20.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    
    // MARK: - Core Data stack
    
    func save(currencylist : [Dictionary<String, String>.Element]) {
        DispatchQueue.main.async { [self] in
            deleteCurrencyList()
            let managedContext = persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: CURRENCY, in: managedContext)!
            
            for item in currencylist {
                let currency = NSManagedObject(entity: entity, insertInto: managedContext)
                currency.setValue(item.key, forKey: KEY)
                currency.setValue(item.value, forKey: VALUE)
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteCurrencyList() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CURRENCY)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch  {
        }
    }
    
    func loadAllCurrencies() -> [Dictionary<String, String>.Element]  {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CURRENCY)
        var list = [Dictionary<String, String>.Element]()
        do {
            let result = try  managedContext.fetch(request)
            print(result.count)
            for data in result as! [NSManagedObject] {
                let key = data.value(forKey: KEY) as! String
                let value = data.value(forKey: VALUE) as! String
                list.append(contentsOf: [key:value])
            }
        } catch {
            print("err")
        }
        return list
    }
    
    func loadAllQuotes() -> [Dictionary<String, Double>.Element] {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: QUOTES)
        var list = [Dictionary<String, Double>.Element]()
        do {
            let result = try  managedContext.fetch(request)
            print(result.count)
            for data in result as! [NSManagedObject] {
                let key = data.value(forKey: KEY) as! String
                let value = data.value(forKey: VALUE) as! Double
                list.append(contentsOf: [key:value])
            }
        } catch {
            print("err")
        }
        return list
    }
    
    func deleteQuotes() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: QUOTES)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch  {
        }
    }
    
    func save(quoteList : [Dictionary<String, Double>.Element]) {
        DispatchQueue.main.async { [self] in
            deleteQuotes()
            let managedContext = persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: QUOTES, in: managedContext)!
            
            for item in quoteList {
                let quote = NSManagedObject(entity: entity, insertInto: managedContext)
                quote.setValue(item.key, forKey: KEY)
                quote.setValue(item.value, forKey: VALUE)
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    
    
    func dictToJson(dict:Dictionary<String, String>) -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dict) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            }
        }
        return ""
    }
    
    func dictToJson(dict:Dictionary<String, Double>) -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dict) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            }
        }
        return ""
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "coredata")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
