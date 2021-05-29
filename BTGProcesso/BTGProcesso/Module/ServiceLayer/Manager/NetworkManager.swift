//
//  ServiceLayer.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation


public class NetworkManager {

    private var session = {
        URLSession.shared
    }()
    
    private var decoder: JSONDecoder = {
       JSONDecoder()
    }()
    
    public func request<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do{
                let object = try self.decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}
