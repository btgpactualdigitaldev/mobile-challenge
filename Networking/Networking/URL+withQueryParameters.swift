//
//  URL+withQueryParameters.swift
//  Networking
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

extension URL {
    func with(queryParameters: [String : Any]) -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryParameters.map { entry in URLQueryItem(name: entry.key, value: "\(entry.value)") }
        guard let urlWithQueryParamaters = urlComponents?.url else { return nil }
        return urlWithQueryParamaters
    }
}
