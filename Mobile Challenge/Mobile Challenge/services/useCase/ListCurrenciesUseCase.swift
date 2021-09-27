//
//  ListCurrenciesUseCase.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

struct ListCurrenciesUseCase {
    
    // MARK: - Private properties
    
    private var mockedCurrencyRepository: CurrencyRepositoryProtocol?
    
    // MARK: - Initializers
    
    init(mockedCurrencyRepository: CurrencyRepositoryProtocol? = nil) {
        self.mockedCurrencyRepository = mockedCurrencyRepository
    }
    
    // MARK: - Public methods
    
    func list(completion: @escaping ([Currency]?, Error?) -> Void) {
        getCurrencyRepository().getCurrencyList { result in
            switch result {
            case .success(let currenciesDTO):
                saveLocalInfo(currenciesDTO)
                completion(makeCurrencyList(from: currenciesDTO), nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func makeCurrencyList(from dto: CurrenciesDTO) -> [Currency] {
        var currencies = [Currency]()
        
        for (key, value) in dto.currencies {
            currencies.append(Currency(id: key, description: value))
        }
        
        return currencies.sorted(by: { $0.id < $1.id })
    }
    
    
    private func currencyListIsSaved() -> Bool {
        UserDefaults.standard.object(forKey: Constants.currenciesDTOKey.rawValue) != nil
    }
    
    private func getCurrencyRepository() -> CurrencyRepositoryProtocol {
        if mockedCurrencyRepository != nil {
            return mockedCurrencyRepository!
        }
        
        if currencyListIsSaved() {
          return CurrencyLocalRepository()
        }
        
        return CurrencyRemoteRepository()
    }
    
    private func saveLocalInfo(_ currenciesDTO: CurrenciesDTO) {
        if mockedCurrencyRepository == nil && !currencyListIsSaved() {
            CurrencyLocalRepository().saveCurrencyList(currenciesDTO: currenciesDTO)
        }
    }
}

