//
//  Moeda.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

struct Moeda: Equatable {
    
    // MARK: Properties
    
    var descricao: String
    var identificador: String
    
    
    // MARK: Initializers
    
    init(_ moedaEntity: MoedaEntity) {
        self.descricao = moedaEntity.descricao ?? ""
        self.identificador = moedaEntity.identificador ?? ""
    }
    
    init(_ descricao: String, identificador: String) {
        self.descricao = descricao
        self.identificador = identificador
    }
    
    
    // MARK: Equatable
    
    static func == (lhs: Moeda, rhs: Moeda) -> Bool {
        return lhs.identificador == rhs.identificador
    }
}

extension MoedaEntity {
    func toMoeda() -> Moeda {
        return Moeda(self)
    }
}
