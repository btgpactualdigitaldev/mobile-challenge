//
//  Service.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

class Service<T: Target> {
    
    var executor: AppExecutor
    var urlSession: URLSession
    
    init() {
        self.urlSession = .init(configuration: URLSessionConfiguration.default)
        self.executor = .init()
    }
    
    @discardableResult
    public func fetch<V: Codable>(_ target: T,
                                  dataType: V.Type,
                                  completion: @escaping (Result<V, BTGError>, URLResponse?) -> Void) -> URLSessionDataTask {
        
        let request = composeRequest(target)
        
        let dataTask = self.executor.execute(request: request, session: urlSession) { (data, response, error) in
            if let _ = error {
                completion(.failure(BTGError.unkown), response)
            }
            
            do {
                if let object  = try self.parseData(data, type: dataType) {
                    completion(.success(object), response)
                    return
                }
                completion(.failure(BTGError.generic("Please try again")), response)
                return
            } catch {
                completion(.failure(BTGError.parse), response)
                return
            }
        }
        
        return dataTask
        
    }
    
    private func composeRequest<T: Target>(_ target: T) -> URLRequest {
        guard let url = urlComponents(target)?.url else { fatalError("An error has ocurred. Please try again later") }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = target.headers
        request.httpMethod = target.method.rawValue
        
        /* Even though I have no more option, if I get a different kind of taks, it comes over here.
         * The default isn't there, it should fail fast and loud
        */
        switch target.task {
        case .requestPlain:
            return request
        }
        
    }
    
    private func urlComponents<T: Target>(_ target: T) -> URLComponents? {
        let url = URL(with: target)
        var components = URLComponents(string: url.absoluteString)
        var resultQueryItems: [URLQueryItem] = []
        resultQueryItems += target.queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = resultQueryItems
        return components
    }
    
    private func parseData<V: Codable>(_ data: Data?, type: V.Type) throws -> V? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        let object = try decoder.decode(type.self, from: data)
        return object
        
    }
    
}
