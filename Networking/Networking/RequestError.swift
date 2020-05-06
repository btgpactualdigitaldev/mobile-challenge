//
//  RequestError.swift
//  Networking
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

public enum RequestError: Error, LocalizedError, CustomStringConvertible, Hashable {
    
    case unmapped(Error)
    case serverError(Error)
    case notHTTPURLResponse
    case unknownStatusCode(Int)
    case queryParameters(URL, [String : Any])
    case emptyResponse(URL)
    case decoding(Error)
    case urlEncoding(String)
    case conversionToData
    
    var localizedDescription: String {
        switch self {
        case .unmapped(let error): return error.localizedDescription
        case .notHTTPURLResponse: return "The response received isn't of type HTTPURLResponse."
        case .unknownStatusCode(let status): return "Unknown status code \(status)."
        case let .queryParameters(url, parameters): return "Unable to create query parameters \(parameters) for \(url)."
        case .emptyResponse(let url): return "The response from \(url) is empty."
        case .decoding(let error): return "Unable to decode: \(error)"
        case .urlEncoding(let string): return "Unable to url encode '\(string)'"
        case .conversionToData: return "Unable to convert to data."
        case .serverError(let error): return "An error happend in the server: \(error)"
        }
    }
    
    public var description: String {
        return self.localizedDescription
    }
    
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(localizedDescription)
    }
}
