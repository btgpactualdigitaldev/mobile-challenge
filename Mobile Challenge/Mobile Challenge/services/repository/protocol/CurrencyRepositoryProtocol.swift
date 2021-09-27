//
//  CurrencyRepositoryProtocol.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

protocol CurrencyRepositoryProtocol {
    func getCurrencyList(completion: @escaping (Result<CurrenciesDTO, Error>) -> Void)
    func getCurrentDollarQuote(completion: @escaping (Result<CurrentDollarQuoteDTO, Error>) -> Void)
}
