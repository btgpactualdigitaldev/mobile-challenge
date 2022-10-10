//
//  APIClient.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func request<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}

public class APIClient: APIClientProtocol {
    
    private let method: HTTPMethod
    
    init(method: HTTPMethod = .get) {
        self.method = method
    }
    
    func request<T>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) where T : APIRequest {
        let endpoint: URLRequest
                
        do {
            endpoint = try getRequest(for: request, url: UIApplication.urlRoot)
        } catch let error{
            completion(.failure(error.localizedDescription))
            return
        }
        
        AF.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(responseData.error?.localizedDescription ?? "Failure on getting response from server."))
                return
            }
            
            let stringData = String(data: data, encoding: .utf8)
            print("Response body: \(stringData ?? "")")
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(error.localizedDescription))
            }
        }
    }
        
    internal func getRequest<T: APIRequest>(for request: T, url: String) throws -> URLRequest {
        guard var baseURL = URLComponents(string: try url.asURL().appendingPathComponent(request.path).absoluteString) else {
            fatalError("Bad resource name: \(request.path)")
        }
        
        print("Method \(method.rawValue): \(baseURL)")
        baseURL.queryItems = [ URLQueryItem(name: "access_key", value: UIApplication.apiKey) ]
        
        guard let url = baseURL.url else { fatalError() }
        var requestData = URLRequest(url: url)
        
        requestData.httpMethod = self.method.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestData
    }
}
