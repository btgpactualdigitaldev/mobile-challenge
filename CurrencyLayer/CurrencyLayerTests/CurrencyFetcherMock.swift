//
//  CurrencyFetcherMock.swift
//  CurrencyLayerTests
//
//  Created by Filipe Cruz on 14/12/20.
//

@testable import CurrencyLayer
import Combine
class CurrencyFetcherMock: CurrencyLayerFetcher {
  private var quotes =  ["USD":1.0, "BRL":5.03]
  private var availableCurrencies = ["USD": "United States Dolar", "BRL": "Brazilian Real"]
  
  override func getCurrencyExangeList() -> AnyPublisher<CurrencyLayerResponse, CurrencyLayerError> {
    return Just(CurrencyLayerResponse(quotes: quotes))
          .setFailureType(to: CurrencyLayerError.self)
          .eraseToAnyPublisher()
  }
  
  override func getSupportedCurrencies() -> AnyPublisher<CurrencyListResponse, CurrencyLayerError> {
    return Just(CurrencyListResponse(currencies: availableCurrencies))
          .setFailureType(to: CurrencyLayerError.self)
          .eraseToAnyPublisher()
  }
}
