//
//  CoreDataStack.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation
import CoreData

class CoreDataStack: CoreDataProtocol {
    
    static var standard = CoreDataStack()
    private static let container = "mobile_challenge"
    
    private init() {}
    
    /// Container to persist objects.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.container)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
