//
//  CurrenciesService.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class CurrenciesService {
    public func fetchList() -> AnyPublisher<[ListItem], ServiceError> {
        Network(Endpoints.list.url)
            .request(ListDTO.self)
            .tryMap { listDTO in
                if let currencies = listDTO.currencies, currencies.isEmpty {
                    throw ServiceError.isEmpty
                }
                return listDTO.currencies?.compactMap { (key: String, value: String) in
                    ListItem(code: key, countryName: value)
                } ?? []
            }
            .mapError { error in
                switch error {
                case is URLError:
                    return .sessionFailed
                case ServiceError.isEmpty:
                    return .isEmpty
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
