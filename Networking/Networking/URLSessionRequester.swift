//
//  URLSessionRequester.swift
//  Networking
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine

public class URLSessionRequester: Requester {
    
    public init() { }
    
    public func request(at url: URL, method: HTTPMethod, headers: [String : String] = [:], queryParameters: [String : Any] = [:], body: Data? = nil) -> AnyPublisher<RequestResponse, RequestError> {
        
        return Future { promise in
            
            guard let request = createRequest(url: url, method: method, headers: headers, queryParameters: queryParameters, body: body) else {
                promise(.failure(.queryParameters(url, queryParameters)))
                return
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    promise(.failure(.unmapped(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { promise(.failure(.notHTTPURLResponse)); return }
                guard let status = HTTPStatusCode(rawValue: httpResponse.statusCode) else { promise(.failure(.unknownStatusCode(httpResponse.statusCode))); return }
                return promise(.success(RequestResponse(data: data, status: status, request: request)))
            }
            
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
}

fileprivate func createRequest(url: URL, method: HTTPMethod, headers: [String : String], queryParameters: [String : Any], body: Data?) -> URLRequest? {
    guard let urlWithQueryParamaters = url.with(queryParameters: queryParameters) else { return nil }
    
    var request = URLRequest(url: urlWithQueryParamaters)
    request.allHTTPHeaderFields = headers
    request.httpMethod = method.rawValue
    request.httpBody = body
    return request
}
