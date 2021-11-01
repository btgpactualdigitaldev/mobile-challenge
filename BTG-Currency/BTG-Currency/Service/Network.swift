//
//  Network.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

struct Network {
    //MARK: - Attributes
    private var url: URL
    private var session: URLSession
    
    //MARK: - Initializer
    init(_ url: URL, session: URLSession = URLSession.shared) {
        self.url = url
        self.session = session
    }
    
    //MARK: - Methods
    func request<T: Decodable>(_ objectType: T.Type) -> AnyPublisher<T, Error> {
        session
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
