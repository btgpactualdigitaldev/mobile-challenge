//
//  CurrencyRepository.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

protocol CurrencyRepositoryProtocol {
    func getCurrencies(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void)
}
