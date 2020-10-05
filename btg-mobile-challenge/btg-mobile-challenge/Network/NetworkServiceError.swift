//
//  NetworkServiceError.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import Foundation

/// List of possible errors resulting from interactions with
/// `NetworkService`.
enum NetworkServiceError: Error {
    case requestFailed
    case unexpectedResponseType
    case unexpectedHTTPStatusCode
    case missingData
    case decodingFailed
}

extension NetworkServiceError {
    var description: String {
        switch self {
        case .requestFailed:
            return "Request failed."
        case .unexpectedResponseType:
            return "Received unexpected response type. Expected HTTP."
        case .unexpectedHTTPStatusCode:
            return "Received unexpected HTTP status code."
        case .missingData:
            return "Missing data from response."
        case .decodingFailed:
            return "Decoding failed."
        }
    }
}
