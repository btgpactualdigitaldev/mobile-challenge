//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Method to prepare Currency data to be shown in the view
class CurrencyListViewModel {

    //Properties
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    var currencies = [CurrencyModel]()
    
    var currenciesByName: [CurrencyModel] {
        return currencies.sorted { $0.name < $1.name }
    }
    
    var currenciesByCode: [CurrencyModel] {
        return currencies.sorted { $0.code < $1.code }
    }
    
    /// Method to fetch Data from API and if fails atribute local data
    /// - Parameter completion: completion indicating if operation is finished and if it is successful
    func fetchCurrencies(completion: @escaping (NetworkError?) -> Void ) {
        var listModel: ListModel?
        var liveModel: LiveModel?
        var networkError: NetworkError?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManager.request(model: ListModel.self) { (result) in
            switch result {
            case .success(let listModelData):
                listModel = listModelData
            case .failure(let error):
                networkError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManager.request(model: LiveModel.self) { (result) in
            switch result {
            case .success(let liveModelData):
                UserDefaults.timeStamp = liveModelData.timestamp
                liveModel = liveModelData
            case .failure(let error):
                networkError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.buildCurrencyModel(list: listModel, live: liveModel)
            if self.currencies.isEmpty {
                networkError = .unknownError
                self.coreDataManager.fetch(completion: { (result) in
                    switch result{
                    case (.success(let currencies)):
                        self.currencies = currencies
                    default:
                        print("default")
                    }
                    completion(networkError)
                })
            } else {
                let values = self.currencies.map({$0.getValuesDict()})
                self.coreDataManager.create(values: values)
                completion(networkError)
            }
            
        }
    }
    
    /// Method to make data from API fit into CurrencyModel
    /// - Parameters:
    ///   - list: Struct fetched from API list call
    ///   - live:  Struct fetched from API live call
    private func buildCurrencyModel(list: ListModel?, live: LiveModel?) {
        guard let currencyNames = list?.currencies else { return }
        guard let currencyValues = live?.quotes else { return }
        
        for (key, value) in currencyNames {
            guard let exchangeValue = currencyValues["USD\(key)"] else { return }
            currencies.append(CurrencyModel(code: key, name: value, value: exchangeValue))
        }
    }
}
