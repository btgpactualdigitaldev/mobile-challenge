//
//  LocalDataProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

protocol LocalDataInteractorInput {
    func load() -> [CurrencyEntity]
    func save(entites: [CurrencyEntity])
}
