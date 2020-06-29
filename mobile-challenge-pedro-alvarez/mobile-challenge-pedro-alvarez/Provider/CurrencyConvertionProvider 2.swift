//
//  CurrencyConvertionProvider.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol CurrencyConvertionProviderProtocol {
    func fetchLive(completion: @escaping CurrencyConvertionJSONCallback)
}

enum CurrencyConvertionResponse {
    case success(CurrencyConvertionJSONModel)
    case error(Error)
    case genericError
}

class CurrencyConvertionProvider: CurrencyConvertionProviderProtocol {
    
    func fetchLive(completion: @escaping CurrencyConvertionJSONCallback) {
        guard InternetConnection.shared.isConnected else {
            guard let data = CurrencySaves.shared.retrieve(file: .convertions) else {
                return
            }
            do {
                let jsonModel = try JSONDecoder().decode(CurrencyConvertionJSONModel.self, from: data)
                completion(.success(jsonModel))
            } catch {
                completion(.genericError)
            }
            return
        }
        APIProvider.shared.fetch(withEndpoint: .live) { response in
            switch response {
            case .success(let data):
                do {
                    CurrencySaves.shared.save(data: data, file: .convertions)
                    let jsonModel = try JSONDecoder().decode(CurrencyConvertionJSONModel.self, from: data)
                    completion(.success(jsonModel))
                } catch {
                    completion(.genericError)
                }
                break
            case .clientError(let error):
                completion(.error(error))
                break
            case .errorToFetchData:
                completion(.genericError)
                break
            }
        }
    }
}
