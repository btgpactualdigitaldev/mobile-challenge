//
//  DataManager.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 22/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import CoreData

class DataManager: NSObject {
    
    private var coreDataStack = CoreDataStack.shared
    
    var viewContext: NSManagedObjectContext {
        return coreDataStack.persistentContainer.viewContext
    }
    
    func savingQuotes(with conversionCurrencies: ConversionModel) {        
          self.syncQuotes(with: conversionCurrencies, taskContext: viewContext)
    }

    func syncQuotes(with conversionCurrencies: ConversionModel, taskContext: NSManagedObjectContext) {
        if let userEntity = NSEntityDescription.entity(forEntityName: "ConversionModel", in: taskContext) {
            conversionCurrencies.conversion.forEach { conversionQuotes in
                let user = NSManagedObject(entity: userEntity, insertInto: taskContext)
                user.setValue(conversionQuotes.code, forKeyPath: "code")
                user.setValue(conversionQuotes.quotes, forKey: "quotes")
                user.setValue(conversionCurrencies.date, forKey: "timestamp")
            }
            
            do {
                try taskContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
}
