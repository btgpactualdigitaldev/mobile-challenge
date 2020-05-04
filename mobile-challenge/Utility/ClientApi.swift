//
//  ClientApi.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

final class ClientApi {
  
  // MARK: - Init
  
  private let url = "http://api.currencylayer.com"
  private let key = "01e1094551d9f88fa5c01ec84516c1fe"
  private var session : URLSession?
  
  init() {
    session = URLSession.shared
  }
  
  // MARK: - Fetch Currency
  
  func fetchCurrencyList(completionHandler: @escaping (ResponseOptionsCurrency) -> Void){
    let connection = session?.dataTask(with: URL(string: "\(url)/list?access_key=\(key)")!, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error accessing swapi.co: \(error)")
        completionHandler(ResponseOptionsCurrency.ErrorResponse("Connection Error"))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        completionHandler(ResponseOptionsCurrency.ErrorResponse(String(describing: response)))
        return
      }
      guard let data = data else { return }
      if let currencyResponse = try? JSONDecoder().decode(CurrencyResponse.self, from: data) {
        completionHandler(ResponseOptionsCurrency.SucessResponse(currencyResponse))
      } else {
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
        completionHandler(ResponseOptionsCurrency.ErrorResponse((errorResponse?.error.info)!))
      }
    })
    connection?.resume()
  }
  
  // MARK: - Fetch Quote
  
  func fetchQuoteLive(completionHandler: @escaping (ResponseOptionsQuote) -> Void){
    let connection = session?.dataTask(with: URL(string: "\(url)/live?access_key=\(key)")!, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error accessing swapi.co: \(error)")
        completionHandler(ResponseOptionsQuote.ErrorResponse("Connection Error"))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        completionHandler(ResponseOptionsQuote.ErrorResponse(String(describing: response)))
        return
      }
      guard let data = data else { return }
      if let quoteResponse = try? JSONDecoder().decode(QuoteResponse.self, from: data) {
        completionHandler(ResponseOptionsQuote.SucessResponse(quoteResponse))
      }  else {
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
        completionHandler(ResponseOptionsQuote.ErrorResponse((errorResponse?.error.info)!))
      }
      
    })
    connection?.resume()
  }
  
}
