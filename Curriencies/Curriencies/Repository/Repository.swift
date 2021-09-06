//
//  CurrencyRepository.swift
//  Curriencies
//
//  Created by Ferraz on 02/09/21.
//

enum RepositoryError: Error {
    case generic
    case noData
    case urlUnknown
    case decoderError
}

protocol Repository {
    func fetch<T:Decodable>(endpoint: String,
                            completion: @escaping (Result<T, RepositoryError>) -> Void)
}
