//
//  CambioDAO.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import CoreData

class CambioDAO {
    
    // MARK: Methods
    
    func deleteBy(_ identicador: String) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CambioEntity")
        fetchRequest.predicate = NSPredicate(format: "identificador == %@", identicador)
        let bacthDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try CoreDataManager.context.execute(bacthDeleteRequest)
    }
    
    func insert(_ identifacador: String, valor: Double) {
        DispatchQueue.main.async {
            let cambioEntity = NSEntityDescription.insertNewObject(forEntityName: "CambioEntity", into: CoreDataManager.context)
            cambioEntity.setValue(identifacador, forKey: "identificador")
            cambioEntity.setValue(valor, forKey: "valor")
        }
    }
    
    func selectAll() throws -> [Cambio] {
        var cambios: [Cambio] = []
        let fetchRequest = NSFetchRequest<CambioEntity>(entityName: "CambioEntity")
        let cambioResult = try CoreDataManager.context.fetch(fetchRequest)
        for cambioEntity in cambioResult {
            cambios.append(cambioEntity.toCambio())
        }
        return cambios
    }
}

struct Cambio {
    
    // MARK: Properties
    
    var identificador: String
    var valor: Double
    
    
    // MARK: Initalizers
    
    init(_ cambioEntity: CambioEntity) {
        self.identificador = cambioEntity.identificador ?? ""
        self.valor = cambioEntity.valor
    }
}

extension CambioEntity {
    func toCambio() -> Cambio {
        return Cambio(self)
    }
}
