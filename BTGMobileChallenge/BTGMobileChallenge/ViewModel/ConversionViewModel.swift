//
//  ConversionViewModel.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

class ConversionViewModel {
	private let repository = ApiRequest()
	
	func getQuotationValue(from: String, to: String, quantity: Float, completion: @escaping (Result<Float, ApiRequestError>) -> Void) {
		repository.getCurrentQuotes { response in
			switch response {
			case .success(let currentQuotes):
				if from == currentQuotes.source, let quote = currentQuotes.quotes[from + to] {
					return completion(.success(quantity * quote))
				} else if let fromQuote = currentQuotes.quotes[currentQuotes.source + from], let toQuote = currentQuotes.quotes[currentQuotes.source + to] {
					return completion(.success(quantity * ( toQuote / fromQuote )))
				} else {
					completion(.failure(.quoteNotFound))
				}
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func getAvaliableQuotes(completion: @escaping (Result<[(code: String, description: String)], ApiRequestError>) -> Void) {
		repository.getAvaliableQuotes { response in
			switch response {
			case .success(let avaliableCurrencies):
				var codesAndDescriptions: [(code: String, description: String)] = []
				for currency in avaliableCurrencies.currencies {
					codesAndDescriptions.append((code: currency.key, description: currency.value))
				}
				completion(.success(codesAndDescriptions))
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
