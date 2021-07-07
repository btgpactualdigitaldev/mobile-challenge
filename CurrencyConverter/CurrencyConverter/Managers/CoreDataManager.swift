//
//  CoreDataManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CurrencyConverter")
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
    
    func deleteAllData(entity: String) {
        let managedContext = self.persistentContainer
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.viewContext.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData:NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.viewContext.delete(managedObjectData)
                }
            }
            
            do {
                try managedContext.viewContext.save()
            } catch let error {
                NSLog("%@", error.localizedDescription)
            }
        } catch let error as NSError {
            NSLog("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
