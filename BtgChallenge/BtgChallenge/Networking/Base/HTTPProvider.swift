//
//  HTTPProvider.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 12/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

public typealias ResponseCompletion<T: Decodable> = ((_ result: Swift.Result<T, Error>) -> Void)?

// swiftlint:disable force_unwrapping
class HTTPProvider<Router: HTTPRouter> {
    
    // MARK: - Properties
    
    var timeoutInterval: TimeInterval = 30.0
    var decoder = JSONDecoder()
    
    // MARK: - Methods
    
    func endpoint(router: Router) -> URLRequest {
        var url = router.baseUrl
        url.appendPathComponent(router.path)
        
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = router.parameters.map { (element) in
            URLQueryItem(name: element.key, value: element.value)
        }
        components.queryItems?.append(
            URLQueryItem(name: "access_key", value: Constants.Networking.accessKey)
        )
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = router.method.rawValue
        request.timeoutInterval = timeoutInterval
        request.allHTTPHeaderFields = router.headers
        
        return request
    }
    
    func request<T: Decodable>(router: Router, completion: ResponseCompletion<T>) {
        let request = endpoint(router: router)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion?(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let decodedObject = try self.decoder.decode(T.self, from: data)
                        completion?(.success(decodedObject))
                    } catch {
                        completion?(.failure(error))
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
}
