//
//  NetworkingError.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

enum NetworkingError: String, Error {
    case noDataReceived = "The request did not generate any data. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURL = "The URL is invalid. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
}
