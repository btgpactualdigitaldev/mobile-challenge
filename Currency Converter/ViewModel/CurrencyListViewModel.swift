//
//  CurrencyListViewModel.swift
//  Currency Converter
//
//  Created by Otávio Souza on 28/09/20.
//

import UIKit

class CurrencyListViewModel: NSObject {
    var currencies : [Dictionary<String, String>.Element] = []
    var currenciesSorted : [Dictionary<String, String>.Element] = []
    let dataManager = DataManager()
}

extension CurrencyListViewModel {
    func fetchCurrencies(completion: @escaping (Result<[Dictionary<String, String>.Element], Error>) -> Void) {
        var url = URL(string: baseUrl + list)!
        url.appendQueryItem(name: acess_key, value: apiKey)
        
        ConnectionManager.shared.get(urlString: url.absoluteString, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data) :
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(ListModel.self, from: data)
                    self.currencies = result.currencies.sorted(by: < )
                    self.currenciesSorted = self.currencies
                    self.dataManager.save(currencylist: self.currenciesSorted)
                    
                    completion(.success(self.currencies))
                } catch {
                    do {
                        let result2 = try decoder.decode(ErrorModel.self, from: data)
                        completion(.failure(result2.error))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        })
    }
    
    func loadFromBackup() -> Bool {
        self.currencies = dataManager.loadAllCurrencies().sorted(by: < )
        self.currenciesSorted = self.currencies
        return !self.currenciesSorted.isEmpty
    }
    
    func sortByCode() {
        self.currenciesSorted = self.currencies.sorted(by: {$0.value < $1.value })  
    }
    
    func sortByText() {
        self.currenciesSorted = self.currenciesSorted.sorted(by: < )
    }
}

extension URL {
    
    mutating func appendQueryItem(name: String, value: String?) {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        self = urlComponents.url!
    }
}
