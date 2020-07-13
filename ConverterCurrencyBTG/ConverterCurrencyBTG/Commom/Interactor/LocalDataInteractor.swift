//
//  LocalDataInteractor.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
import CoreData

class LocalDataInteractor: LocalDataInteractorInput {
    
    var manager: LocalDataManager
    
    init(manager: LocalDataManager) {
        self.manager = manager
    }

    func load() -> [CurrencyEntity] {
        return manager.loadData().map({ CurrencyEntity(name: $0.name ?? "", currency: $0.currency ?? "", quotes: $0.quotes?.decimalValue ?? .zero )})
    }
    
    func save(entites: [CurrencyEntity]) {
        manager.deleteAllData("CurrencyModel")
        let _ = entites.map({ CurrencyModel.make(entity: $0) })
        manager.save()
    }
    
}

extension CurrencyModel {
    static func make(entity: CurrencyEntity, context: NSManagedObjectContext = LocalDataManager.persistentContainer.viewContext) -> CurrencyModel {
        let model = CurrencyModel.insertNew(in: context)
        model.currency = entity.currency
        model.name = entity.name
        model.quotes = NSDecimalNumber(decimal: entity.quotes)
        return model
    }
}
