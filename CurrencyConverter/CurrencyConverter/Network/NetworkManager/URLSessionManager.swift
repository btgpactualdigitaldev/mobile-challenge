//
//  URLSessionManager.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

final class URLSessionManager: NetworkManagerProtocol {
    
    func get<T: Decodable>(baseURL: String, parameters: [String : String]?, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Format URL
        guard let validURL = self.formatURL(baseURL: baseURL, parameters: parameters) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Request
        URLSession.shared.dataTask(with: validURL, completionHandler: { data, response, error in
            // Check General Errors
            if let detectedError = error as NSError? {
                if detectedError.code == NSURLErrorDataNotAllowed {
                    completionHandler(.failure(.networkUnavailable))
                } else {
                    completionHandler(.failure(.unknowError))
                }
                return
            }
            
            
            // Check response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completionHandler(.failure(.connectionError))
                return
            }
            
            // Check response type
            guard let mimeType = response?.mimeType, mimeType == "application/json" else {
                completionHandler(.failure(.invalidResponseType))
                return
            }
            
            // Get Data
            guard let responseData = data,
                  let decodedObject = try? JSONDecoder().decode(T.self, from: responseData) else {
                completionHandler(.failure(.objectNotDecoded))
                return
            }
            
            completionHandler(.success(decodedObject))
        }).resume()
        
    }
}

// MARK: - Setup URL
extension URLSessionManager {
    private func formatURL(baseURL: String, parameters: [String: String]?) -> URL? {
        // Format URL
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        // Add Parameters
        if let receivedParameters = parameters, !receivedParameters.isEmpty {
            urlComponents.queryItems = []
            
            for parameter in receivedParameters {
                let queryItem = URLQueryItem(name: parameter.key, value: parameter.value)
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        return urlComponents.url
    }
}

