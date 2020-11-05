//
//  APIError.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

enum APIError: Error {
    
    case urlError
    case decodeError
    case dataError
    case responseError
    
    var errorDescription: String {
        switch self {
        
        case .urlError:
            return "Invalid API url."
            
        case .decodeError:
            return "Can not decode the API response."
        
        case .dataError:
            return "No data available in the request."
            
        case .responseError:
            return "Error with the response."
        }
    }
}
