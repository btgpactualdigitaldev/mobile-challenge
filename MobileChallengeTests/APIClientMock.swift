//
//  APIClientMock.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 13/10/20.
//

import Foundation

class APIClientMock: APIClientProtocol {
    func request<T>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) where T : APIRequest {
        
    }
}
