//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

public enum NetworkError: Error {
    
    case invalidURL
    case internalError
    case notFound
    case parsingError
    
    case unknown
    case parsedData
    case noJSONData
    case apiError((Error & Decodable)?)
    
}
