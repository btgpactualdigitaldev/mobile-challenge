//
//  CurrencyDAO.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import CoreData

class CurrencyDAO: CurrencyInterface {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func fetchWithPredicate(_ predicate: NSPredicate?, withSortDescriptors sortDescriptors: [NSSortDescriptor]?, completion: @escaping ([Currency]) -> Void) throws {

        let fetchRequest = NSFetchRequest<CurrencyCD>(entityName: CurrencyCD.uniqueIdentifier)
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let currenciesCD = try context.fetch(fetchRequest)
        
            var currencies: [Currency] = []
            currencies = currenciesCD.map {
                $0.toDomainModel()
            }
            
            completion(currencies)
        }catch {
            throw CoreDataError.cannotBeFetched
        }
    }
    
    func createWithCurrency(_ currency: Currency) {
        let currencyCD = CurrencyCD(context: self.context)
        currencyCD.name = currency.name
        currencyCD.code = currency.code
        currencyCD.value = currency.value
        
        do {
            try context.save()
        }catch {
            print("Error to save")
        }
    }
    
    func createWithoutRepetitionWithCurrency(_ currency: Currency, withPredicate predicate: NSPredicate?, completion: @escaping () -> Void) {
        
        let fetchRequest = NSFetchRequest<CurrencyCD>(entityName: CurrencyCD.uniqueIdentifier)
        
        fetchRequest.predicate = predicate
        
        do {
            let currenciesCD = try self.context.fetch(fetchRequest)
            
            guard currenciesCD.count == 0 else {
                return completion()
            }
            
            self.createWithCurrency(currency)
            
            completion()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll(completion: @escaping () -> Void) throws {
        let fetchRequest = NSFetchRequest<CurrencyCD>(entityName: CurrencyCD.uniqueIdentifier)
                
        do {
            let currenciesCD = try self.context.fetch(fetchRequest)
        
            for currencyCD in currenciesCD {
                self.context.delete(currencyCD)
            }
            
            
            try context.save()
            completion()
        }catch {
            throw CoreDataError.cannotBeDeleted
        }
    }
    
    
}
