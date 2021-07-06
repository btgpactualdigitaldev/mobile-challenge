//
//  DomainModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
