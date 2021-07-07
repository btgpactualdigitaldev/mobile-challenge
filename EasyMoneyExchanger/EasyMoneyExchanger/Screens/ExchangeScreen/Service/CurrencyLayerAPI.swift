//
//  CurrencyLayerAPI.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation
import UIKit

class CurrencyLayerAPI {

    let apiKey = "0db8ed878f9da1db0a2f1dc91f086f7e"

    // MARK: - Currency Rates

    func fetchCurrencyRates(url: URL, completion: @escaping (Result<CurrencyRates, Errors>) -> Void) {
        let decoder = JSONDecoder()
        //Handling Error
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(Errors.invalidEndpoint))
            return
        }

        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems

        //Handling Error
        guard let queryUrl = urlComponents.url else {
            completion(Result.failure(Errors.invalidEndpoint))
            return
        }

        URLSession.shared.dataTask(with: queryUrl) { (data, response, error) in
            //Handling Error
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(Result.failure(Errors.transportError(error)))
                return
            }

            // Decoding JSON
            do {
                let quotes = try decoder.decode(CurrencyRates.self, from: data!)
                completion(Result.success(quotes))
            } catch {
                //Handling Error
                completion(Result.failure(Errors.transportError(error)))
                return
            }
        }.resume()
    }

    // MARK: - Supported Currencies

    func fetchSupportedCurrencies(url: URL, completion: @escaping (Result<CurrencySupported, Errors>) -> Void) {
        let decoder = JSONDecoder()

        //Handling Error
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(Errors.invalidEndpoint))
            return
        }

        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        //Handling Error
        guard let queryUrl = urlComponents.url else {
            completion(Result.failure(Errors.invalidEndpoint))
            return
        }

        URLSession.shared.dataTask(with: queryUrl) { (data, response, error) in
            //Handling Error
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(Result.failure(Errors.transportError(error)))
                return
            }

            // Decoding JSON
            do {
                let currencies = try decoder.decode(CurrencySupported.self, from: data!)
                completion(Result.success(currencies))
            } catch {
                //Handling Error
                completion(Result.failure(Errors.transportError(error)))
                return
            }
        }.resume()
    }
}

enum Errors: Error {
    case transportError(Error?)
    case invalidEndpoint
}
