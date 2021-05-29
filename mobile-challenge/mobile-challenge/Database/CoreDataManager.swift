//
//  CoreDataManager.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import CoreData

class CoreDataManager {

    private lazy var coreDataStack = CoreDataStack(modelName: "mobile-challenge")
    
    private let currencyQuotationEntity = "CurrencyQuotationEntity"
    
    func create(currenciesQuotation: [CurrencyQuotation], completion: (() -> Void)? = nil) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: currencyQuotationEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        if UserDefaults.hasStoredEntities {
            do {
                try coreDataStack.managedContext.execute(deleteRequest)
            } catch let error as NSError {
                print("Could not delete. \(error)")
            }
        }
        
        for cqEntity in currenciesQuotation {
            let entity = NSEntityDescription.entity(forEntityName: currencyQuotationEntity, in: coreDataStack.managedContext)!
            
            let managedObject = NSManagedObject(entity: entity, insertInto: coreDataStack.managedContext)
            
            managedObject.setValue(cqEntity.code, forKey: "code")
            managedObject.setValue(cqEntity.currency, forKey: "currency")
            managedObject.setValue(cqEntity.quotation, forKey: "quotation")
        }
        
        coreDataStack.saveContext()
        UserDefaults.hasStoredEntities = true
        completion?()
    }
    
    func fetch(completion: @escaping ((Result<[CurrencyQuotation], CurrencyError>) -> Void)) {
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: currencyQuotationEntity)
        
        
        do{
            let objects = try coreDataStack.managedContext.fetch(fetchRequest)
            
            let currenciesQuotation = objects.map { (object) -> CurrencyQuotation in
                
                CurrencyQuotation(code: object.value(forKey: "code") as! String,
                                  currency: object.value(forKey: "currency") as! String,
                                  quotation: object.value(forKey: "quotation") as! Double)
            }
            
            completion(.success(currenciesQuotation))
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(.failure(CurrencyError.CoreDataError))
        }
    }
}
