//
//  CurrencyExchangeRepository.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//

import Foundation
import CoreData
import UIKit

private protocol CurrencyExchangeRepositoryInterface{
    
    // Create a CurrencyExchange on core data
    func create(currencyExchange: [String: Double], completionHandler: @escaping(Result<[String: Double], CoreDataError>)->Void)
    
    // Get a CurrencyExchange using a predicate
    func fetch(predicate: NSPredicate?, sorts: [NSSortDescriptor]?, completionHandler: @escaping(Result<[[String: Double]], CoreDataError>)->Void)
}

class EntryCategoryRepository{
    
    private let repository: CoreDataRepository<CurrencyExchangeCD>
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.repository = CoreDataRepository<CurrencyExchangeCD>(managedObjectContext: context)
    }
}

extension EntryCategoryRepository: CurrencyExchangeRepositoryInterface {
    
    func create(currencyExchange: [String: Double], completionHandler: @escaping(Result<[String: Double], CoreDataError>)->Void){
        
        repository.create(completionHandler: { result in
            
            switch result {
            case .success(let currencyCD):
                
                guard let key = currencyExchange.keys.first, let value = currencyExchange.values.first else {
                    completionHandler(.failure(.invalidCreateData))
                    return
                }
                
                currencyCD.id = UUID()
                currencyCD.code = key
                currencyCD.exchange = value
                
                do {
                    try self.context.save()
                    completionHandler(.success(currencyCD.toDomainModel()))
                } catch {
                    completionHandler(.failure(.invalidSaveData))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func fetch(predicate: NSPredicate?, sorts: [NSSortDescriptor]?, completionHandler: @escaping(Result<[[String: Double]], CoreDataError>)->Void){
        
        repository.fetch(predicate: predicate, sortDescriptors: sorts, completionHandler: { result in
            
            switch result {
            case .success(let currenciesCD):
                
                let currencies = currenciesCD.map { currencyCD -> [String: Double] in
                    return currencyCD.toDomainModel()
                }
                
                completionHandler(.success(currencies))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
