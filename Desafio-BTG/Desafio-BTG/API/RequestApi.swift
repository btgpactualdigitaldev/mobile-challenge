//
//  RequestApi.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation

protocol RealTimeRatesApiProtocol {
    func fetchRealTimeRates(completion: @escaping (Int?, _ details: RealTimeRatesModel?) -> Swift.Void)
}

protocol CurrencyListModelProtocol {
    func fetchCurrencyList(completion: @escaping (Int?, _ details: CurrencyListModel?) -> Swift.Void)
}

class RequestApi: RealTimeRatesApiProtocol, CurrencyListModelProtocol {

    enum BaseUrl {
        static let urlRealTimeRates = "http://api.currencylayer.com/live?access_key=27b8bc6d2b73c0969fd137013349c926"
        static let urlCurrencyList = "http://api.currencylayer.com/list?access_key=27b8bc6d2b73c0969fd137013349c926"
    }
    
    private let connectionManager: ConnectionManager
    
    init(connectionManager: ConnectionManager = ConnectionManager()) {
        self.connectionManager = connectionManager
    }
    
    func fetchRealTimeRates(completion: @escaping (Int?, _ details: RealTimeRatesModel?) -> Swift.Void)  {
        connectionManager.request(url:  BaseUrl.urlRealTimeRates, method: .get, parameters: nil, headers: nil) { (statusCode, details: RealTimeRatesModel?) in
            completion(statusCode, details)
        }
    }
    
    func fetchCurrencyList(completion: @escaping (Int?, CurrencyListModel?) -> Void) {
        connectionManager.request(url:  BaseUrl.urlCurrencyList, method: .get, parameters: nil, headers: nil) { (statusCode, details: CurrencyListModel?) in
            completion(statusCode, details)
        }
    }

}
