//
//  AppExecutor.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

protocol AppExecutorProtocol {
    func execute(request: URLRequest,
                 session: URLSession,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


class AppExecutor: AppExecutorProtocol {
    func execute(request: URLRequest,
                 session: URLSession,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let e = error {
                completion(data, response, e)
                return
            }
            completion(data, response, nil)
        }
        
        task.resume()
        return task
    }
    
}
