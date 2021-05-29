//
//  CoreDataProtocol.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    
    /// Current context.
    var context: NSManagedObjectContext { get }
    
    /// Save modifications in context.
    func saveContext()
}

extension CoreDataProtocol {
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
