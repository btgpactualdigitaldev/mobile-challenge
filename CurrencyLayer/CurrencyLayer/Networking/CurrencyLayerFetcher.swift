//
//  CurrencyLayerFetcher.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 08/12/20.
//

import Foundation
import Combine

protocol CurrencyLayerFetchable {
  func getCurrencyExangeList() -> AnyPublisher<CurrencyLayerResponse, CurrencyLayerError>
  func getSupportedCurrencies() -> AnyPublisher<CurrencyListResponse, CurrencyLayerError>
}

// MARK: - MarvelComics API
private extension CurrencyLayerFetcher {
  struct CurrencyLayerAPI {
    static let scheme = "http"
    static let host = "api.currencylayer.com"
    static let livePath = "/live"
    static let listPath = "/list"
    static let publicKey = "750414e975a3c07b18f488f6fbedd842"
  }
  
  func makeCurrencyListComponents() -> URLComponents {
    var components = URLComponents()
    components.scheme = CurrencyLayerAPI.scheme
    components.host = CurrencyLayerAPI.host
    components.path = CurrencyLayerAPI.livePath

    components.queryItems = [
      URLQueryItem(name: "access_key", value: CurrencyLayerAPI.publicKey),
    ]
    
    return components
  }
  
  func makeCurrenciesDetailsComponents() -> URLComponents {
    var components = URLComponents()
    components.scheme = CurrencyLayerAPI.scheme
    components.host = CurrencyLayerAPI.host
    components.path = CurrencyLayerAPI.listPath

    components.queryItems = [
      URLQueryItem(name: "access_key", value: CurrencyLayerAPI.publicKey)
    ]
    
    return components
  }
}


public class CurrencyLayerFetcher: CurrencyLayerFetchable {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func getCurrencyExangeList() -> AnyPublisher<CurrencyLayerResponse, CurrencyLayerError> {
    return getCurrency(with: makeCurrencyListComponents())
  }
  
  func getSupportedCurrencies() -> AnyPublisher<CurrencyListResponse, CurrencyLayerError> {
    return getCurrency(with: makeCurrenciesDetailsComponents())
  }

  private func getCurrency<T>(with components: URLComponents) -> AnyPublisher<T, CurrencyLayerError> where T: Decodable {
    guard let url = components.url else {
      let error = CurrencyLayerError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }

    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}
