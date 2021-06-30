//
//  CurrencyLiveApiClient.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class CurrencyLiveApiClient: CurrencyApiClient {
    
    static var shared: CurrencyLiveApiClient = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
        config.requestCachePolicy = .useProtocolCachePolicy
        return CurrencyLiveApiClient(configuration: config)
    }()
    
    //fileprivate let defaultParameters = ["access_key" : "864e7197b821f59bc5db86a1d9193d02", "format" : "1", "source" : "USD", "currencies" : ""]
    fileprivate let defaultParameters = ["access_key" : "864e7197b821f59bc5db86a1d9193d02"]

    
    func fetchGetCurrencies(source: String, completion: @escaping (Result<CurrencyResponse, ResponseError>) -> Void) {
        let url = Endpoints<CurrencyLiveApiClient>.getCurrencies.url
        let parameter = ["source" : source].merging(defaultParameters, uniquingKeysWith: +)
        let request = buildRequest(.get, url: url, parameters: parameter)
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(ResponseError.rede))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(CurrencyResponse.self, from: data) else {
                completion(Result.failure(ResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    func fetchListCurrencies(completion: @escaping (Result<CurrencyListResponse, ResponseError>) -> Void) {
        let url = Endpoints<CurrencyLiveApiClient>.listCurrencies.url
        let request = buildRequest(.get, url: url, parameters: defaultParameters)
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(ResponseError.rede))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(CurrencyListResponse.self, from: data) else {
                completion(Result.failure(ResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    override class var baseURL: String {
        return "http://apilayer.net/api"
    }
    
}
