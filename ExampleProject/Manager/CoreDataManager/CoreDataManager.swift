//
//  CoreDataHandler.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 06/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "currencies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchAllCurrencies() -> [Currency]? {
      let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CurrencyModel")
        
      do {
        let dataCurrenciesModel = try managedContext.fetch(fetchRequest) as? [CurrencyModel]
        
        guard let currenciesModel = dataCurrenciesModel, !currenciesModel.isEmpty else { return nil }
        
        var currencies = [Currency]()
        for model in currenciesModel {
            if let currency = Currency(from: model) {
                currencies.append(currency)
            }
        }
        
        return currencies.sorted(by: { $0.initials < $1.initials })
        
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return nil
      }
    }
    
    func saveIfNew(initials: String, name: String) {
        
      let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrencyModel")
        fetchRequest.predicate = NSPredicate(format: "initials = %@", initials)
        
        if let dataCurrenciesModel = try? managedContext.fetch(fetchRequest) as? [CurrencyModel] {
            if !dataCurrenciesModel.isEmpty { return }
        }
        
        
      let entity = NSEntityDescription.entity(forEntityName: "CurrencyModel",
                                              in: managedContext)!
        
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      

        person.setValue(initials, forKeyPath: "initials")
        person.setValue(name, forKeyPath: "name")
      

      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}
