//
//  CurrencyLocalRepository.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

import Foundation

struct CurrencyLocalRepository: CurrencyRepositoryProtocol {
    
    // MARK: - Public properties
    
    let userDefault = UserDefaults.standard
    
    // MARK: - Public methods
    
    func getCurrencyList(completion: @escaping (Result<CurrenciesDTO, Error>) -> Void) {
        guard let dto = retrieveCurrencyListDTO() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        
        return completion(.success(dto))
    }
    
    func getCurrentDollarQuote(completion: @escaping (Result<CurrentDollarQuoteDTO, Error>) -> Void) {
        guard let dto = retrieveCurrentDollarQuoteDTO() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        
        return completion(.success(dto))
    }
    
    func saveCurrencyList(currenciesDTO: CurrenciesDTO) {
        guard let jsonData = try? JSONEncoder().encode(currenciesDTO) else { return }
        
        userDefault.set(String(bytes: jsonData, encoding: .utf8), forKey: Constants.currenciesDTOKey.rawValue)
    }
    
    func saveCurrentDollarQuote(currentDollarQuoteDTO: CurrentDollarQuoteDTO) {
        guard let jsonData = try? JSONEncoder().encode(currentDollarQuoteDTO) else { return }
        
        userDefault.set(String(bytes: jsonData, encoding: .utf8), forKey: Constants.dollarQuoteDTOKey.rawValue)
    }
    
    // MARK: - Private methods
    
    private func retrieveCurrencyListDTO() -> CurrenciesDTO? {
        guard let jsonString = userDefault.string(forKey: Constants.currenciesDTOKey.rawValue), let jsonData = jsonString.data(using: .utf8), let dto = try? JSONDecoder().decode(CurrenciesDTO.self, from : jsonData) else { return nil }
        
        return dto
    }
    
    private func retrieveCurrentDollarQuoteDTO() -> CurrentDollarQuoteDTO? {
        guard let jsonString = userDefault.string(forKey: Constants.dollarQuoteDTOKey.rawValue), let jsonData = jsonString.data(using: .utf8), let dto = try? JSONDecoder().decode(CurrentDollarQuoteDTO.self, from : jsonData) else { return nil }
        
        return dto
    }
    
}
