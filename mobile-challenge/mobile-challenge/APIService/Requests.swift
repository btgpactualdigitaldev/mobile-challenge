//
//  Requests.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

public enum TaskAnswer<T> {
    case result(T)
    case error(Error)
}

class Requests {
    
    /**
     This function performs a get request, transforms its answer into a Decodable, and triggers a completion handler with its answer.
     
     - Warning: This method is asyncronous.
     
     - Parameter url: The url address to make the requisition.
     - Parameter endpoint: The endpoint to be appended at the end of the URL.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter header: The request's header dictionary.
     - Parameter queries: The URL queries.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func getRequest<T: Decodable>(
        url: String,
        endpoint: String?,
        decodableType: T.Type,
        header: [String: String]? = nil,
        queries: [URLQueryItem]? = nil,
        completion: @escaping (TaskAnswer<Any>) -> Void ) {
        
        //Creating a request and making sure it exists
        guard let request = createRequest(url: url, endpoint: endpoint, header: header, queries: queries) else {
            completion(TaskAnswer.error(URLParsingError()))
            return
        }
        
        //Creating the get task with the request, and executing it
        createTask(request: request as URLRequest, decodableType: decodableType, completion: completion).resume()
    }
    
    /**
     Creates the URLRequest using the specified URL.
     
     - Parameter url: The URL to create the request.
     - Parameter endpoint: The endpoint to be appended at the end of the URL.
     - Parameter header: The request's header dictionary.
     - Parameter queries: The URL queries.
     */
    private static func createRequest(url: String,
                                      endpoint: String?,
                                      header: [String:String]?,
                                      queries: [URLQueryItem]?) -> URLRequest? {
        
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        // Persisting queries that is already in url
        var urlQueryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        // Append each new query
        for query in queries ?? [] {
            urlQueryItems.append(query)
        }
        
        // Update URL Components
        urlComponents.queryItems = urlQueryItems
        
        // Unwrapping URL from URL Components
        guard var URL = urlComponents.url else {
            return nil
        }
        
        // Append endpoint if needed
        if let endpoint = endpoint {
            URL.appendPathComponent(endpoint)
        }
                
        var request = URLRequest(url: URL)
        
        // Add each header parameter to the request
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }
        
        return request
    }
    
    /**
     Creates a DataTask from a URL request, and when resumed, triggers a completion handler with its answer.
     
     - Warning: This method is asyncronous.
     
     - Parameter request: The URL Request.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    private static func createTask<T: Decodable>(request: URLRequest,
                                                 decodableType: T.Type,
                                                 completion: @escaping (TaskAnswer<Any>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(TaskAnswer.error(DataTaskError()))
                return
            }

            do {
                // Try to decode the response
                let response = try JSONDecoder().decode(decodableType, from: data)
                completion(TaskAnswer.result(response))
            } catch {
                // Error of decoding or service communication
                completion(TaskAnswer.error(DataTaskError()))
            }
        }
        return task
    }
}
