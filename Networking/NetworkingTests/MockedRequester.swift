//
//  MockedRequester.swift
//  NetworkingTests
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Networking
import Combine

struct MockedRequester: Requester {
    let mock: Mock
    
    func request(at url: URL, method: HTTPMethod, headers: [String : String], queryParameters: [String : Any], body: Data?) -> AnyPublisher<RequestResponse, RequestError> {
        switch mock {
        case .success(let response): return Just(response).setFailureType(to: RequestError.self).eraseToAnyPublisher()
        case .failure(let response): return Fail(outputType: RequestResponse.self, failure: response).eraseToAnyPublisher()
        }
    }
    
    enum Mock {
        case success(RequestResponse)
        case failure(RequestError)
    }
}
