//
//  APIInstanceGetter.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 13/10/20.
//

import Foundation

class APIInstance {
    
    func get() -> APIClientProtocol {
        if Thread().isRunningXCTest {
            return APIClientMock()
        }
        return APIClient()
    }
}
