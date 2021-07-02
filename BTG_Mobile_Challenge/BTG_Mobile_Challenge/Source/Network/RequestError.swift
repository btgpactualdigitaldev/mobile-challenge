//
//  RequestError.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

public protocol RequestError: LocalizedError {
    var title: String? { get }
}

struct NotURLError: RequestError {
    var title: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid parse to URL."
        self._description = description
    }
}

struct InvalidCodableError: RequestError {
    var title: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid Codable Object."
        self._description = description
    }
}

struct RequestFailedError: RequestError {
    var title: String?
    private var _description: String
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    init(title: String?, description: String) {
        self.title = title ?? "Unable to complete the Request"
        self._description = description
    }
}

struct PurposefulError: RequestError {
    var title: String?
    private var _description: String
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    init(title: String?, description: String) {
        self.title = title ?? "purposeful Error"
        self._description = description
    }
}
