//
//  URLRequest+Service.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

extension URLRequest {

    /// Initiliaze a URLRequest with a Service (Protocol) as param
    ///
    /// - Parameter service: a Service Protocol instance
    public init(service: Service) {
        if let urlComponents = URLComponents(service: service),
            let url = urlComponents.url {
            self.init(url: url)

            self.httpMethod = service.method.rawValue

            service.headers?.forEach { key, value in
                addValue(value, forHTTPHeaderField: key)
            }

            if case let .requestWithBody(payload) = service.task,
                service.parametersEncoding == .json {
                if let payloadEncoded = payload.asData() {
                    self.httpBody = payloadEncoded
                }
            }
            
            if case let .requestParameters(parameters) = service.task,
                service.parametersEncoding == .json {
                if let parametersEncoded = parameters.asData() {
                    self.httpBody = parametersEncoded
                }
            }

        } else {
            self.init(url: URL(fileURLWithPath: ""))
        }
    }
    
}
