//
//  APIProvider.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 25/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

class APIProvider {
    
    enum Endpoints: String {
        case list = "list"
        case live = "live"
    }
    
    enum DataResponse {
        case success(Data)
        case clientError(Error)
        case errorToFetchData
    }
    
    static let shared: APIProvider = APIProvider()
    
    private let baseURL = "http://api.currencylayer.com/"
    private let accessKey = "cd74d98d74f757a573c927a7070568b5"
    private let accessKeyHeader = "access_key="
    
    private init() { }
    
    func fetch(withEndpoint endpoint: Endpoints, completion: @escaping DataResponseCallback) {
        guard let url = getCompletedURL(forEndpoint: endpoint) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                if let error = error {
                    completion(.clientError(error))
                }
                return
            }
            guard let data = data else {
                completion(.errorToFetchData)
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

}

extension APIProvider {
    
    private func getCompletedURL(forEndpoint endpoint: Endpoints) -> URL? {
        let urlString = baseURL + endpoint.rawValue + .interrogation + accessKeyHeader + accessKey
        let url = URL(string: urlString)
        return url
    }
}
