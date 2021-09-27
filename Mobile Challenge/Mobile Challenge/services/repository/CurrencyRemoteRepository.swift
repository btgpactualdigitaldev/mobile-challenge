//
//  CurrencyRepository.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

struct CurrencyRemoteRepository: CurrencyRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let apiClient = ApiClient.shared
    
    // MARK: - Public methods
    
    func getCurrencyList(completion: @escaping (Result<CurrenciesDTO, Error>) -> Void) {
        apiClient.execute(returnModel: CurrenciesDTO.self, request: GetCurrenciesRequest()) { result in
            switch result {
            case .success(let currenciesDTO):
                completion(.success(currenciesDTO))
                
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrentDollarQuote(completion: @escaping (Result<CurrentDollarQuoteDTO, Error>) -> Void) {
        apiClient.execute(returnModel: CurrentDollarQuoteDTO.self, request: GetCurrentDollarQuoteRequest()) { result in
            switch result {
            case .success(let currentDollarQuoteDTO):
                completion(.success(currentDollarQuoteDTO))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
