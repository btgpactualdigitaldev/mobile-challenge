//
//  QuotaAPI.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation


public class QuotaAPI {
    
    private let manager: NetworkManager = {
        NetworkManager()
    }()
    
    func request<T: Decodable>(with resource: APIResource, completion: @escaping (T?) -> Void) {
        do {
            let request = try resource.request()
            manager.request(with: request) { (result: Result<T, Error>) in
                switch result {
                
                case .success(_):
                    completion(try? result.get())
                case .failure(_):
                    completion(nil)
                }
            }
        } catch {
            completion(nil)
        }
    }
}
