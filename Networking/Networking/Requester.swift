//
//  URLSessionRequester.swift
//  Networking
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine

public protocol Requester {
    func request(at url: URL, method: HTTPMethod, headers: [String : String], queryParameters: [String : Any], body: Data?) -> AnyPublisher<RequestResponse, RequestError>
}

extension Requester {
    public func get(from url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:]) -> AnyPublisher<RequestResponse, RequestError> {
        return request(at: url, method: .get, headers: headers, queryParameters: queryParameters, body: nil)
    }
    
    public func get<Response: Decodable & Hashable, Decoder: TopLevelDecoder>(from url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], decoder: Decoder) -> AnyPublisher<RequestDecodedResponse<Response>, RequestError> where Decoder.Input == Data {
        
        return get(from: url, headers: headers, queryParameters: queryParameters)
            .decode(from: url, decoder: decoder)
            .mapError { $0 as? RequestError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
    
    public func post(to url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], body: Data? = nil) -> AnyPublisher<RequestResponse, RequestError> {
        return request(at: url, method: .post, headers: headers, queryParameters: queryParameters, body: body)
    }
    
    public func post<Response: Decodable & Hashable, Decoder: TopLevelDecoder>(to url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], decoder: Decoder, body: Data? = nil) -> AnyPublisher<RequestDecodedResponse<Response>, RequestError> where Decoder.Input == Data {
        
        return post(to: url, headers: headers, queryParameters: queryParameters, body: body)
            .decode(from: url, decoder: decoder)
            .mapError { $0 as? RequestError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
}

fileprivate extension Publisher where Output == RequestResponse {
    func decode<Response: Decodable, Decoder: TopLevelDecoder>(from url: URL, decoder: Decoder) -> Publishers.TryMap<Self, RequestDecodedResponse<Response>> where Decoder.Input == Data {
        return self.tryMap { response -> RequestDecodedResponse<Response> in
            guard let data = response.data else { throw RequestError.emptyResponse(url)  }
                do {
                    let decoded = try decoder.decode(Response.self, from: data)
                    return RequestDecodedResponse(data: decoded, status: response.status, request: response.request)
                } catch {
                    throw RequestError.decoding(error)
                }
        }
    }
}




