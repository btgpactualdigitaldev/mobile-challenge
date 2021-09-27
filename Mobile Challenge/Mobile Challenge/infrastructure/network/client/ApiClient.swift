//
//  ApiClient.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

final class ApiClient {
    
    // MARK: - Public properties
    
    static let shared = ApiClient()
    
    // MARK: - Initalizer
    
    private init() { }
    
    // MARK: - Private methods
    
    private func createRequest(_ request: Requestable) -> URLRequest? {
        
        guard let serverURL = Bundle.main.object(forInfoDictionaryKey: Constants.serverURL.rawValue) as? String, let endpoint = URL(string: "\(serverURL)\(request.url)") else {
            return nil
        }
        
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.timeoutInterval = request.timeout
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
        
    }

    // MARK: - Public methods
    
    func execute<T : Codable>(returnModel: T.Type, request: Requestable, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = createRequest(request) else {
            completion(.failure(NSError(domain: "", code: ApiError.createRequestError.rawValue, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorCode = (response as? HTTPURLResponse)?.statusCode ?? ApiError.noHttpStatusCode.rawValue
                completion(.failure(NSError(domain: "", code: errorCode, userInfo: nil)))
                return
            }
            
            if let data = data, let model = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(model))
            }
        }.resume()
        
    }
}
