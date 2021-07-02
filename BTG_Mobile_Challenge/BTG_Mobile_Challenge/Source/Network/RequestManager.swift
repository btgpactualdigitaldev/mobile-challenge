//
//  RequestManager.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

fileprivate struct NilCodable: Codable {
}

enum HttpMethods: String {
    case get = "GET"
}

final class RequestManager {
    
    private let service: NetworkService
    
    init(service: NetworkService = URLSession.shared) {
        self.service = service
    }

    func createRequest(url: String, method: HttpMethods) -> NSMutableURLRequest? {
        guard let URL = URL(string: url) else {
            return nil
        }
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = method.rawValue
        return request
    }

    /**
     This function performs a get request, transforms its answer into a Decodable, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter header: The request's header, separated by key and values.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    func getRequest<T: Decodable>(
        url: String,
        decodableType: T.Type,
        header: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void) {

        //Creating a request and making sure it exists.
        guard let request = createRequest(url: url, method: .get) else {
            completion(.failure(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        //Adding each header parameter to the request.
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }

        //Creating the get task with the request, and executing it.
        service.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let serviceError = error {
                completion(.failure(serviceError))
                ErrorHandlerObject().genericErrorHandling(title: "Error with service", message: error?.localizedDescription ?? "No Localized Description")
                return
            }
            
            guard let httpResponse =  response as? HTTPURLResponse else {
                completion(.failure(NotURLError(title: nil, description: "Couldn't use URL as Response")))
                ErrorHandlerObject().genericErrorHandling(title: "Error with Http Response", message: error?.localizedDescription ?? "No Localized Description")
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                guard let data = data else {
                    completion(.failure(RequestFailedError(title: nil, description: "Couldn't retrive data from URL")))
                    ErrorHandlerObject().genericErrorHandling(title: "Couldn't retrive data from URL", message: error?.localizedDescription ?? "No Localized Description")
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(decodableType.self, from: data) 
                    completion(.success(decoded))
                }  catch {
                    completion(.failure(InvalidCodableError(title: nil, description: "Couldn't decode object retrivied from URL")))
                    ErrorHandlerObject().genericErrorHandling(title: "Couldn't decode object retrivied from URL", message: error.localizedDescription )
                }
            } else {
                completion(.failure(RequestFailedError(title: nil, description: "Network request failed due to unexpected HTTP status code.")))
            }
        }.resume()
    }
}
