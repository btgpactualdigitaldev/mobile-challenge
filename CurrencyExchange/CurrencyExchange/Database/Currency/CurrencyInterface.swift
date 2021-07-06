//
//  CurrencyDatabaseInterface.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import CoreData

protocol CurrencyInterface {
    
    var context: NSManagedObjectContext { get set }
    
    func fetchWithPredicate(_ predicate: NSPredicate?, withSortDescriptors sortDescriptors: [NSSortDescriptor]?, completion: @escaping ([Currency]) -> Void) throws
    
    func createWithCurrency(_ currency: Currency)
    
    func deleteAll(completion: @escaping () -> Void) throws
    
    func createWithoutRepetitionWithCurrency(_ currency: Currency, withPredicate predicate: NSPredicate?, completion: @escaping () -> Void)
}
