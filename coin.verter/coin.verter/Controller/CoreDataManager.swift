//
//  CoreDataManager.swift
//  coin.verter
//
//  Created by Caio Berkley on 23/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveInformationFromArray(currencyArray: [Currency]) {
        
        for i in currencyArray {
            
            let context = persistentContainer.viewContext
            let currency = LocalCurrency(context: context)
            
            currency.key = i.key
            currency.value = i.value
            
            try? context.save()
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
