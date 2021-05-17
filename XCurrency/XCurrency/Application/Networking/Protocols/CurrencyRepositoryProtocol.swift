//
//  CurrencyRepositoryProtocol.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

protocol CurrencyRepositoryProtocol {
    
    // MARK: - Attributes
    var network: Networking { get }
    
    // MARK: - Methods
    func getCurrencyList(completion: @escaping(Result<CurrencyObject, Error>) -> Void)
    func getCurrenciesRate(completion: @escaping(Result<CurrencyRateObject, Error>) -> Void)
}
