//
//  CurrencyMockedRepository.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

import Foundation

struct CurrencyMockedRepository: CurrencyRepositoryProtocol {
    
    // MARK: - Public properties
    
    var mockedCurrenciesDTO: CurrenciesDTO?
    var mockedCurrentDollarQuoteDTO: CurrentDollarQuoteDTO?
    var mockedError: Error?
    
    // MARK: - Public methods
    
    func getCurrencyList(completion: @escaping (Result<CurrenciesDTO, Error>) -> Void) {
        if let mockedError = mockedError {
            completion(.failure(mockedError))
            return
        }
        
        if let mockedCurrenciesDTO = mockedCurrenciesDTO {
            completion(.success(mockedCurrenciesDTO))
            return
        }
        
        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
    }
    
    func getCurrentDollarQuote(completion: @escaping (Result<CurrentDollarQuoteDTO, Error>) -> Void) {
        if let mockedError = mockedError {
            completion(.failure(mockedError))
            return
        }
        
        if let mockedCurrentDollarQuoteDTO = mockedCurrentDollarQuoteDTO {
            completion(.success(mockedCurrentDollarQuoteDTO))
            return
        }
        
        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
    }
    
}
