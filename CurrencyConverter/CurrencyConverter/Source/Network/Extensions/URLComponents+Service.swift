//
//  URLComponents+Service.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

extension URLComponents {

    /// Initialize a URLComponents with Service (Protocol) instance as param
    ///
    /// - Parameter service: a Service Protocol instance
    public init?(service: Service) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)

        guard case let .requestParameters(parameters) = service.task,
            service.parametersEncoding == .url else {
                return
        }

        self.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
    
}
