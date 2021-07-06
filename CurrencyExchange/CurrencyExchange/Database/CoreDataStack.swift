//
//  CoreDataStack.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//


import CoreData

class CoreDataStack {
    
    private init(){}
    
    static var shared = CoreDataStack()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CurrencyExchange")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Returns the current container view context
    lazy var viewContext : NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Test mockups
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "CurrencyExchange")
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Chama erro no coredata do test (error.userInfo)")
            }
        }

        return container
    }()
}
