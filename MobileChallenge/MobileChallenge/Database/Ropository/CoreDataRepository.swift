//
//  CoreDataRepository.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//

import Foundation
import CoreData

import Foundation

protocol Repository {
    associatedtype Entity
    
    func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completionHandler: @escaping(Result<[Entity], CoreDataError>) -> Void)
    
    func create(completionHandler: @escaping(Result<Entity, CoreDataError>) -> Void)
}

class CoreDataRepository<T: NSManagedObject>: Repository{
    typealias Entity = T
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func create(completionHandler: @escaping(Result<T, CoreDataError>)->Void){
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else{
            return completionHandler(.failure(.invalidCreateData))
        }
        completionHandler(.success(managedObject))
    }
    
    func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completionHandler: @escaping(Result<[T], CoreDataError>)->Void) {
        
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        
        do {
            if let fetchResults = try
                managedObjectContext.fetch(fetchRequest) as? [Entity]{
                completionHandler(.success(fetchResults))
            }else{
                completionHandler(.failure(.invalidEntityCast))
            }
        } catch {
            completionHandler(.failure(.invalidFetchData))
        }
    }
}
