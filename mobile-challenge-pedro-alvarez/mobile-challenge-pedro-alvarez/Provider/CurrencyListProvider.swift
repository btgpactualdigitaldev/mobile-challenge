//
//  CurrencyListProvider.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol CurrencyListProviderProtocol {
    func fetchList(completion: @escaping CurrencyListJSONCallback)
}

enum CurrencyListResponse {
    case success(CurrencyListJSONModel)
    case error(Error)
    case genericError
}

class CurrencyListProvider: CurrencyListProviderProtocol {
    
    func fetchList(completion: @escaping CurrencyListJSONCallback) {
        guard InternetConnection.shared.isConnected else {
            guard let data = CurrencySaves.shared.retrieve(file: .list) else {
                return
            }
            do {
                let jsonModel = try JSONDecoder().decode(CurrencyListJSONModel.self, from: data)
                completion(.success(jsonModel))
            } catch {
                completion(.genericError)
            }
            return
        }
        APIProvider.shared.fetch(withEndpoint: .list) { result in
            switch result {
            case .success(let data):
                do {
                    CurrencySaves.shared.save(data: data, file: .list)
                    let jsonModel = try JSONDecoder().decode(CurrencyListJSONModel.self, from: data)
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
