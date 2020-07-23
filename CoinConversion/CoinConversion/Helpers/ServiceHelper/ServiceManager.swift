//
//  ServiceManager.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - ServiceManager
final class ServiceManager: ServiceManagerProtocol {
    
    func request(method: ServiceHTTPMethod,
                 url: String,
                 parameters: [String : Any]?,
                 encoding: ServiceEncoding,
                 success: @escaping (Data) -> Void,
                 failure: @escaping ((ServiceError) -> ())) {
        
        // Type used to define how a set of parameters are applied to request
        let requestEncoding: ParameterEncoding = {
            switch encoding {
            case .default: return URLEncoding.default
            case .json: return JSONEncoding.default
            }
        }()
        
        // HTTP method used
        let requestMethod = HTTPMethod(rawValue: method.rawValue)!
        
        if !Connectivity.isConnectedToInternet() {
            failure(ServiceError(type: .noConnection))
            return
        }
        
        // Request
        Alamofire.request(url,
                          method: requestMethod,
                          parameters: parameters,
                          encoding: requestEncoding,
                          headers: nil)
            
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    guard let responseData = response.data else {
                        failure(ServiceError(type: .notFound))
                        return
                    }
                    
                    success(responseData)
                    
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        failure(ServiceError(type: .timeOut))
                        return
                    }
                    
                    switch response.response?.statusCode {
                    case 403:
                        failure(ServiceError(type: ServiceError.RequestError(code: 403)))
                    case 401:
                        failure(ServiceError(type: ServiceError.RequestError(code: 401)))
                    case 400:
                        break;
                    default:
                        failure(self.handleFailure(with: response))
                    }
                }
        }
    }
    
    private func handleFailure(with response: DataResponse<Any>) -> ServiceError {
        
        guard let statusCode = response.response?.statusCode else {
            return ServiceError(type: .notFound)
        }
        
        switch statusCode {
        case ServiceError.RequestError.notFound.code:
            return ServiceError(type: .notFound, object: response.data)
        default:
            let errorType = ServiceError.RequestError(code: statusCode)
            return ServiceError(type: errorType)
        }
    }
}
