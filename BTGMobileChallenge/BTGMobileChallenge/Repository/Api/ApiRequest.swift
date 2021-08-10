//
//  ApiRequest.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

class ApiRequest {
	private enum Endpoint: String {
		case live = "/live"
		case list = "/list"
	}
	
	private let networkMonitor = NetworkMonitor.shared
	private let mainPath = "https://btg-mobile-challenge.herokuapp.com"
		
	private func getEntireUrl(_ endpoint: Endpoint) -> String {
		return mainPath + endpoint.rawValue
	}
	
	func getAvaliableQuotes(completionHandler: @escaping (Result<AvaliableQuotes, ApiRequestError>) -> Void) {
		guard networkMonitor.isReachable else { return completionHandler(.failure(.noInternetConnection)) }
		let urlString = getEntireUrl(.list)
		guard let url = URL(string: urlString) else { return completionHandler(.failure(.invalidUrl)) }
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else { return completionHandler(.failure(.responseError)) }
			do {
				let response = try JSONDecoder().decode(AvaliableQuotes.self, from: data)
				completionHandler(.success(response))
			} catch {
				completionHandler(.failure(.decodingError))
			}
		}

		task.resume()
	}
	
	func getCurrentQuotes(completionHandler: @escaping (Result<CurrentQuotes, ApiRequestError>) -> Void) {
		guard networkMonitor.isReachable else { return completionHandler(.failure(.noInternetConnection)) }
		let urlString = getEntireUrl(.live)
		guard let url = URL(string: urlString) else { return completionHandler(.failure(.invalidUrl)) }
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else { return completionHandler(.failure(.responseError)) }
			do {
				let response = try JSONDecoder().decode(CurrentQuotes.self, from: data)
				completionHandler(.success(response))
			} catch {
				completionHandler(.failure(.decodingError))
			}
		}
		
		task.resume()
	}
}

