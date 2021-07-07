//
//  CurrencyAPIService.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

class CurrencyAPIService {
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    
    
    // MARK: - Initialization
    init(networkManager: NetworkManagerProtocol = URLSessionManager()) {
        self.networkManager = networkManager
    }
    
    
    // MARK: Fetch Methods
    func fetchCurrencyNames(completionHandler: @escaping (Result<[String: String], Error>) -> Void) {
        let url = self.createURL(serviceType: .currencyNames)
        
        networkManager.get(baseURL: url.baseURL, parameters: url.parameters, completionHandler: { (result: Result<CurrencyNamesAPIResponse, NetworkError>) in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let currencyAPIResponse):
                completionHandler(.success(currencyAPIResponse.currencies))
            }
        })
    }
    
    func fetchCurrencyValuesInDollar(completionHandler: @escaping (Result<[String: Double], Error>) -> Void) {
        let url = self.createURL(serviceType: .currencyValues)
        
        networkManager.get(baseURL: url.baseURL, parameters: url.parameters, completionHandler: { (result: Result<CurrencyValuesAPIResponse, NetworkError>) in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let currencyAPIResponse):
                completionHandler(.success(currencyAPIResponse.quotes))
            }
        })
    }
    
    func fetchAllCurrencies(completionHandler: @escaping (Result<[Currency], Error>) -> Void) {
        
        // Fetch Currency Names
        fetchCurrencyNames(completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let receivedCurrencyNames):
                
                // Fetch Currency Names
                self.fetchCurrencyValuesInDollar(completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        completionHandler(.failure(error))
                    case .success(let receveidCurrencyValuesInDollar):
                        do {
                            let currencies = try self.handleCurrencyObject(currencyNames: receivedCurrencyNames, currencyValuesInDollar: receveidCurrencyValuesInDollar)
                            
                            if currencies.isEmpty {
                                completionHandler(.failure(CurrencyAPIError.emptyCurrencyArray))
                            } else {
                                completionHandler(.success(currencies))
                            }
                        } catch {
                            completionHandler(.failure(error))
                        }
                    }
                })
            }
        })
    }
}

// MARK: - Setup URL
extension CurrencyAPIService {
    private func createURL(serviceType: CurrencyAPISources.ServiceType) -> (baseURL: String, parameters: [String: String]?) {
        var baseURL = CurrencyAPISources.baseURL
        let APIKey = CurrencyAPISources.APIKey
        
        switch serviceType {
        case .currencyNames:
            baseURL += CurrencyAPISources.currencyNamesExtensionURL
        case .currencyValues:
            baseURL += CurrencyAPISources.currencyValuesExtensionURL
        }
        
        let parameters: [String: String] = [
            CurrencyAPISources.ParameterName.APIKey: APIKey
        ]
        
        return (baseURL, parameters)
    }
}


// MARK: - Handle Currency Objects
extension CurrencyAPIService {
    private func handleCurrencyObject(currencyNames: [String: String], currencyValuesInDollar: [String: Double]) throws -> [Currency] {
        let dollarCode = "USD"
        let dollarConversionKey = "USDUSD"
        var currencies: [Currency] = []
        
        for currencyValue in currencyValuesInDollar {
            // Check if is Dollar
            var currencyCode = String()
            
            if currencyValue.key == dollarConversionKey {
                currencyCode = dollarCode
            } else {
                currencyCode = currencyValue.key.replacingOccurrences(of: dollarCode, with: "")
            }
            
            // Value In Dollar
            let currencyValueInDollar = currencyValue.value

            // Name
            guard let currencyName = currencyNames[currencyCode] else {
                throw CurrencyAPIError.invalidCurrencyName
            }
            
            let currency = Currency(name: currencyName, code: currencyCode, valueInDollar: currencyValueInDollar)
            currencies.append(currency)
        }
        
        return currencies
    }
}
