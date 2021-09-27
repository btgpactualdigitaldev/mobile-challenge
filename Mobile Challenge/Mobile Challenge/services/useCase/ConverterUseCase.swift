//
//  ConverterUseCase.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

struct ConverterUseCase {
    
    // MARK: - Private properties
    
    private var mockedCurrencyRepository: CurrencyRepositoryProtocol?
    
    // MARK: - Initializers
    
    init(mockedCurrencyRepository: CurrencyRepositoryProtocol? = nil) {
        self.mockedCurrencyRepository = mockedCurrencyRepository
    }
    
    // MARK: - Public methods
    
    func convert(value: Double, from sourceCurrency: String, to targetCurrency: String, completion: @escaping (Double?, Error?) -> Void) {
        getDollarQuote(from: sourceCurrency) { dollarQuote, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let dollarQuote = dollarQuote else {
                completion(0, nil)
                return
            }
            
            let sourceToUSD = value/dollarQuote
            
            getDollarQuote(from: targetCurrency) { result, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let result = result else {
                    completion(0, nil)
                    return
                }

                completion(sourceToUSD * result, nil)
            }
        }
        
    }
    
    // MARK: - Private methods
    
    private func getDollarQuote(from sourceCurrency: String, completion: @escaping (Double?, Error?) -> Void) {
        getCurrencyRepository().getCurrentDollarQuote { result in
            switch result {
            case .success(let currentDollarQuoteDTO):
                guard let quote = currentDollarQuoteDTO.quotes["USD\(sourceCurrency)"] else {
                    completion(0.0, nil)
                    return
                }
                self.saveLocalInfo(currentDollarQuoteDTO)
                completion(quote, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private func currentDollarQuoteIsSaved() -> Bool {
        UserDefaults.standard.object(forKey: Constants.dollarQuoteDTOKey.rawValue) != nil
    }
    
    private func getCurrencyRepository() -> CurrencyRepositoryProtocol {
        if mockedCurrencyRepository != nil {
            return mockedCurrencyRepository!
        }
        
        if currentDollarQuoteIsSaved() {
            return CurrencyLocalRepository()
        }
        
        return CurrencyRemoteRepository()
    }
    
    private func saveLocalInfo(_ currentDollarQuoteDTO: CurrentDollarQuoteDTO) {
        if mockedCurrencyRepository == nil && !currentDollarQuoteIsSaved() {
            CurrencyLocalRepository().saveCurrentDollarQuote(currentDollarQuoteDTO: currentDollarQuoteDTO)
        }
    }

}
