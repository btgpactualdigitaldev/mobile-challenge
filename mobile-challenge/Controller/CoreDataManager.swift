//
//  CoreDataManager.swift
//  mobile-challenge
//
//  Created by Alan Silva on 14/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /*func saveContext(){
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            
            do{
                try context.save()
            }
            catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
        
    }*/
    
    func saveInformationFromArray(currencyArray: [Currency]) {
        
        for i in currencyArray {
            
            let context = persistentContainer.viewContext
            let currency = LocalCurrency(context: context)
            
            currency.key = i.key
            currency.value = i.value
            
            try? context.save()
            //saveContext()
        }
        
    }
    
    func loadInformationFromCoreData(completion:([Currency]?) -> Void) {
        
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalCurrency")
        let result = try? context.fetch(request)
        let arrayCurrency = result as? [LocalCurrency] ?? []
        
        var array : [Currency] = []
        
        for i in arrayCurrency {
            
            let currencyObj : Currency = Currency(key: i.key!, value: i.value!)
            array.append(currencyObj)
        }
        
        completion(array)
        
    }
    
    func deleteInformationFromCoreData(completion: (Bool) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalCurrency")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentContainer.viewContext
        
        do {
            try context.execute(deleteRequest)
            debugPrint("Deleted Entitie - ", "LocalCurrency")
            completion(true)
        } catch let error as NSError {
            debugPrint("Delete ERROR \("LocalCurrency")")
            debugPrint(error)
            completion(false)
        }
        
    }
    
}
