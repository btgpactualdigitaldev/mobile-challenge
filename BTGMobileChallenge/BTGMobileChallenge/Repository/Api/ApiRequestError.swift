//
//  ApiRequestError.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 10/08/21.
//

import Foundation

enum ApiRequestError: Error {
	case invalidUrl
	case noInternetConnection
	case decodingError
	case responseError
	case quoteNotFound
}
