//
//  CoreDataStorage.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation
import CoreData

class CoreDataManager {

    private(set) var connector: CoreDataProtocol
    private let currencyEntity = "Currency"

    init(connector: CoreDataProtocol = CoreDataStack.standard) {
        self.connector = connector
    }
    
    func create(values: [[String : Any]], completion: (() -> Void)? = nil) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: currencyEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try connector.context.execute(deleteRequest)
        } catch {
           
        }
        
        for value in values {
            let entity = NSEntityDescription.entity(forEntityName: currencyEntity, in: connector.context)!
            let managedObject = NSManagedObject(entity: entity, insertInto: connector.context)
            
            managedObject.setValuesForKeys(value)
        }
        
        connector.saveContext()
        completion?()
    }
    
    func fetch(completion: @escaping ((Result<[CurrencyModel], Error>) -> Void)) {
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: currencyEntity)
        
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result) in
            
            guard let objects = result.finalResult else {
                completion(.failure(DatabaseError.notFound))
                return
            }
            
            let currencies = objects.map { (object) -> CurrencyModel in
                CurrencyModel(code: object.value(forKey: "code") as! String,
                              name: object.value(forKey: "name") as! String,
                              value: object.value(forKey: "value") as! Double)
            }
            
            completion(.success(currencies))
        }
        
        do {
            try connector.context.execute(asyncRequest)
        } catch {
            completion(.failure(error))
        }
    }
}
