//
//  CurrencyClient.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

struct CurrencyQuoteResponse: CurrencyLayerResponse {
    public let success: Bool
    public let timestamp: Int64
    public let source: String
    public let quotes: [String: Double]
}

struct CurrencyNameResponse: CurrencyLayerResponse {
    public let success: Bool
    public let currencies: [String: String]
}

protocol CurrencyClientProtocol {
    typealias SynchronyzeQuotesResponse = (Result<Void, HttpClient.HttpError>) -> Void
    func synchronizeQuotes(result: @escaping SynchronyzeQuotesResponse)
}

class CurrencyClient: HttpClient, CurrencyClientProtocol {
    typealias CurrencyQuoteResult = (Result<CurrencyQuoteResponse, HttpError>) -> Void
    typealias CurrencyNameResult = (Result<CurrencyNameResponse, HttpError>) -> Void
    
    func getCurrenciesQuotes(result: @escaping CurrencyQuoteResult) {
        request(method: "live", completion: result)
    }
    
    func listCurrenciesNames(result: @escaping CurrencyNameResult) {
        request(method: "list", completion: result)
    }
    
    func synchronizeQuotes(result: @escaping SynchronyzeQuotesResponse) {
        getCurrenciesQuotes { currenciesQuotesResult in
            switch currenciesQuotesResult {
            case .success(let currenciesQuotesResponse):
                self.listCurrenciesNames { listCurrenciesResult in
                    switch listCurrenciesResult {
                    case .success(let listCurrenciesResponse):
                        let saved = CurrencyData.save(quotesResponse: currenciesQuotesResponse, namesResponse: listCurrenciesResponse)
                        if saved {
                            result(.success(()))
                        } else {
                            result(.failure(.ServerError))
                        }
                    case .failure(let error):
                        result(.failure(error))
                    }
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    
}
