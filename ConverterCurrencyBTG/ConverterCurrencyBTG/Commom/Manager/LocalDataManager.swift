//
//  LocalDataManager.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
import CoreData

class LocalDataManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ConverterCurrencyBTG")
    
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
   static  var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        do {
            return try NSPersistentStoreCoordinator.coordinator(name: "ConverterCurrencyBTG")
        } catch {
            
        }
        return nil
    }()
    
    
    func loadData() -> [CurrencyModel] {
       return LocalDataManager.persistentContainer.viewContext.fetchAll(CurrencyModel.self)
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try LocalDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                LocalDataManager.persistentContainer.viewContext.delete(objectData)
            }
            save()
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func save() {
        
        LocalDataManager.persistentContainer.viewContext.performAndWait {
            if LocalDataManager.persistentContainer.viewContext.hasChanges {
                do {
                    try LocalDataManager.persistentContainer.viewContext.save()
                } catch {
                    print("Failure to save context: \(error)")
                }
            }
        }
        
    }
}
