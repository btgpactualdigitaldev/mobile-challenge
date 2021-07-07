//
//  NetworkManage.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

final class NetworkManage {
    func request<T:Decodable>(service: ServiceProtocol,
                              resposeType: T.Type,
                              completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: service.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.value
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard error == nil else {
                var networkError: NetworkError = .unknowError
                if error!.localizedDescription.uppercased().contains("OFFLINE") {
                    networkError = .offline
                }
                completion(.failure(networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.connectionError))
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                completion(.failure(.invalidResponseType))
                return
            }
            
            guard
                let data = data,
                let object: T = self.decode(data: data) else {
                completion(.failure(.objectNotDecoded))
                return
            }
            
            completion(.success(object))
        }.resume()
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        guard let object = try? decoder.decode(T.self, from: data) else { return nil }
        
        return object
    }
}
