//
//  APISource.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import Foundation

enum ApiResoureError: String, Error {
    case urlError
}

enum EndPoint: String {
    case live
    case list
    case historical
    case convert
    case timeframe
    case change
}
enum Parameter: String {
    case accessKey = "?access_key="
    case to
    case from
    case format
    case currencies
    case date
    case source
    case amount
    case startDate = "start_date"
    case endDate = "end_date"
}
enum HTTPMethod: String{
    case get
    case post
}

struct APIResource {
    
    private let url: String = "http://apilayer.net/api/"
    private let key: String = "97ac0b64d2dada39138895a15674720d"
    private let endpoint: EndPoint
    private let httpMethod: HTTPMethod
    private let parameters: [Parameter: String]
    
    init(endpoint: EndPoint, httpMethod: HTTPMethod, parameters: [Parameter: String]) {
        self.parameters = parameters
        self.httpMethod = httpMethod
        self.endpoint = endpoint
    }
    
    func request() throws -> URLRequest {
        do{
            var request = URLRequest(url: try configureURL())
            request.httpMethod = self.httpMethod.rawValue
            return request
        } catch let error {
            throw error
        }
    }
    
    private func configureURL() throws -> URL {
        
        var newUrl = url + endpoint.rawValue + Parameter.accessKey.rawValue + key
        for (key,value) in parameters {
            newUrl += "&" + key.rawValue + "=" + value
        }
        
        if let URL = URL(string: newUrl) {
            return URL
        } else {
            throw ApiResoureError.urlError
        }
    }
    
}
