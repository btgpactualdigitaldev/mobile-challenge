//
//  CoreDataError.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//

import Foundation

enum CoreDataError: Error{
    case invalidCreateData
    case invalidFetchData
    case invalidSaveData
    case invalidEntityCast
    
    var errorDescription: String {
        switch self {
        
        case .invalidCreateData:
            return "Error when create data"
            
        case .invalidFetchData:
            return "Error when fetch data"
            
        case .invalidSaveData:
            return "Error when save data"
            
        case .invalidEntityCast:
            return "Error when cast data"
        }
    }
}

