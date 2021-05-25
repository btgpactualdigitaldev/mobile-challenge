//
//  ConnectionManager.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation
import Alamofire

class ConnectionManager {
     func request<T: Decodable>(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completionHandler: @escaping (Int?, T?) -> ()) {
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            var statusCode: Int = Int()
            
            let serverStatusCode = response.response?.statusCode ?? -1
            
            statusCode = serverStatusCode
            
            let error = response.result.isFailure
            if error {
                print(error)
            }
            
            if let error = response.result.error as? AFError {
                print(error)
            }
            
            print(response)
            
            switch response.result {
                case .success(let response) :
                    let decoder = JSONDecoder()
                    do {
                        let jsonData = try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                        let data = try decoder.decode(T.self, from: jsonData)
                        completionHandler(statusCode, data)
                    } catch let error {
                        print(error)
                    }
            case .failure(_):
                completionHandler(statusCode, nil)
            }
        }
    }
}
