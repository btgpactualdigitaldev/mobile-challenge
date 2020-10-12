//
//  ApiRequests.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

public class ApiRequests {

    internal static func request<T: Codable>(_ router: Router, completion: @escaping (_ response: T?, _ error: String?) -> Void) {

        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let json = try decoder.decode(T.self, from: data!)
                completion(json, nil)
            } catch {
                do {
                    let requestFail = try decoder.decode(ErrorModel.self, from: data!)
                    if let code = requestFail.error.first(where: {$0.key == "code"})!.value.value() as? Int {
                        completion(nil, Errors.getErrorDescritption(errorCode: code))
                    }
                } catch {
                    completion(nil, Errors.getErrorDescritption(errorCode: 999))
                }
            }
        }

        task.resume()
    }
    
}

