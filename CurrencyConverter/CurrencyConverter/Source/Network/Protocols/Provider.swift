//
//  Provider.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

public protocol Provider {
    func request<T: Decodable>(type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void)
}
