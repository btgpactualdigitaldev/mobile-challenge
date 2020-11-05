//
//  CurrencyNameRepository.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//

import Foundation
import CoreData
import UIKit

private protocol CurrencyNameRepositoryInterface{
    
    // Create a CurrencyName on core data
    func create(currencyName: [String: String], completionHandler: @escaping(Result<[String: String], CoreDataError>)->Void)
    
    // Get a CurrencyName using a predicate
    func fetch(predicate: NSPredicate?, sorts: [NSSortDescriptor]?, completionHandler: @escaping(Result<[[String: String]], CoreDataError>)->Void)
}

class CurrencyNameRepository{
    
    private let repository: CoreDataRepository<CurrencyNameCD>
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.repository = CoreDataRepository<CurrencyNameCD>(managedObjectContext: context)
    }
}

extension CurrencyNameRepository: CurrencyNameRepositoryInterface {
    
    func create(currencyName: [String: String], completionHandler: @escaping(Result<[String: String], CoreDataError>)->Void){
        
        repository.create(completionHandler: { result in
            
            switch result {
            case .success(let currencyCD):
                
                guard let key = currencyName.keys.first, let value = currencyName.values.first else {
                    completionHandler(.failure(.invalidCreateData))
                    return
                }
                
                currencyCD.id = UUID()
                currencyCD.code = key
                currencyCD.name = value
                
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
    
    func fetch(predicate: NSPredicate?, sorts: [NSSortDescriptor]?, completionHandler: @escaping(Result<[[String: String]], CoreDataError>)->Void){
        
        repository.fetch(predicate: predicate, sortDescriptors: sorts, completionHandler: { result in
            
            switch result {
            case .success(let currenciesCD):
                
                let currencies = currenciesCD.map { currencyCD -> [String: String] in
                    return currencyCD.toDomainModel()
                }
                
                completionHandler(.success(currencies))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
