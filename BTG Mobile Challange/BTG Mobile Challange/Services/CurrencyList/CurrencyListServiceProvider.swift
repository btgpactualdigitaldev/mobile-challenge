//
//  CurrencyListServiceProvider.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

class CurrencyListServiceProvider: CurrencyListServiceProtocol {

    let serviceEndpoint = "/list"

    func fetchCurrencyList(completion: @escaping CurrencyListServiceCallback) {
        DispatchQueue.main.async {
            guard let urlComponents = NSURLComponents(string: ApiHelper.baseURL + self.serviceEndpoint) else {
                completion(.failure(ApiError.genericError))
                return
            }
            urlComponents.queryItems = [URLQueryItem(name: "access_key", value: ApiHelper.currencyApiKey)]
            guard let url = urlComponents.url else {
                completion(.failure(ApiError.genericError))
                return
            }
            var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: ApiHelper.connectionTimeout)
            request.httpMethod = "POST"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let data = data else {
                    completion(.failure(URLError.cannotDecodeRawData as! Error))
                    return
                }
                do {
                    let decodedData = try JSONDecoder.init().decode(CurrencyListModel.self, from: data)
                    guard decodedData.error == nil, decodedData.error?.info == nil else {
                        completion(.failure(ApiError.apiError(errorDescription: (decodedData.error?.info)!)))
                        return
                    }
                    completion(.success(decodedData))
                    return
                } catch(let error) {
                    completion(.failure(error))
                    return
                }
            }.resume()
        }
    }
}
