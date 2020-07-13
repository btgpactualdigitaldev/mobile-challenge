//
//  Extension+NSManagedObject.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let matches = try fetch(fetchRequest)
            return (matches as? [T]) ?? []
        } catch {
            return []
        }
    }
    
    func fetch<T: NSManagedObject>(_ entity: T.Type, serverId: Int64) -> T? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        fetchRequest.predicate = NSPredicate(format: "serverId = %@", NSNumber(value: serverId))
        
        do {
            let matches = try fetch(fetchRequest)
            
            return matches.first as? T
        } catch {
            return nil
        }
    }
    
    //    MARK: - Delete Batch
    func deleteBatch<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        //        fetchRequest.predicate = predicate
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try LocalDataManager.persistentStoreCoordinator?.execute(deleteBatch, with: LocalDataManager.persistentContainer.viewContext)
        } catch (let error) {
            debugPrint(error)
        }
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> T? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let matches = try fetch(fetchRequest)
            return matches.first as? T
        } catch {
            return nil
        }
    }
}
