//
//  ServiceError.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 30/10/21.
//

import UIKit

public enum ServiceError: Error {
    case isEmpty
    case sessionFailed
    case missingCurrency
    case unknown
    
    var image: UIImage {
        switch self {
        case .isEmpty, .sessionFailed:
            return UIImage(systemName: "xmark.icloud")!
        case .missingCurrency:
            return UIImage(systemName: "exclamationmark.icloud")!
        case .unknown:
            return UIImage(systemName: "xmark.octagon")!
        }
    }
}

//MARK: - LocalizedError attributes
extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingCurrency:
            return NSLocalizedString("One of determined currencies was not find", comment: "")
        case .isEmpty:
            return NSLocalizedString("No data was returned from server", comment: "")
        case .sessionFailed:
            return NSLocalizedString("While trying to reach the server, an error has occurred", comment: "")
        case .unknown:
            return NSLocalizedString("An unknown error has occurred", comment: "")
        }
    }
}
