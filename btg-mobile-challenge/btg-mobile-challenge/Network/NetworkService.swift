//
//  NetworkService.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// The service responsible for performing network requests.
protocol NetworkService {
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
