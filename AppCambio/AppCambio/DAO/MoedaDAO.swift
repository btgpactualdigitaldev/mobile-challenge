//
//  MoedaDAO.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import CoreData

class MoedaDAO {
    
    // MARK: Methods
    
    func deleteAll() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoedaEntity")
        let bacthDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try CoreDataManager.context.execute(bacthDeleteRequest)
    }
    
    func insert(_ descricao: String, identificador: String) {
        DispatchQueue.main.async {
            let moedaEntity = NSEntityDescription.insertNewObject(forEntityName: "MoedaEntity", into: CoreDataManager.context)
            moedaEntity.setValue(descricao, forKey: "descricao")
            moedaEntity.setValue(identificador, forKey: "identificador")
        }
    }
    
    func selectAll() throws -> [Moeda] {
        var moedas: [Moeda] = []
        let fetchRequest = NSFetchRequest<MoedaEntity>(entityName: "MoedaEntity")
        let moedasResult = try CoreDataManager.context.fetch(fetchRequest)
        for moedaEntity in moedasResult {
            moedas.append(moedaEntity.toMoeda())
        }
        return moedas
    }
}
