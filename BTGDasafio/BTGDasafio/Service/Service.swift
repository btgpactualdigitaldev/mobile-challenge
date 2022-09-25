//
//  Service.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 28/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import Foundation

class ServiceManager {
    private let baseUrl = "http://api.currencylayer.com/"
    private let APIKey = "?access_key=4b627b34ea876d250d2de102e39c9160"

    enum EndPoints: String {
        case live
        case list
    }

    static let sharedInstance = ServiceManager()
    private func formatUrl(_ endPoint: EndPoints) -> String {
        return "\(baseUrl)\(endPoint)\(APIKey)"
    }
    
    func exchangeRateListRequest(completion: @escaping (ExchangeRate?, String?) -> Void) -> Void {
        request(url: formatUrl(.list)) { (data, err) in
            guard err == nil, let data = data else {
                completion(nil, err)
                return
            }
            do {
                let exchangeRate: ExchangeRate = try JSONDecoder().decode(ExchangeRate.self, from: data)
                completion(exchangeRate, nil)
            } catch let err{
                completion (nil, err.localizedDescription)
            }
        }
    }

    func currentQuoteRequest(completion: @escaping (CurrentQuote?, String?) -> Void) -> Void {
        request(url: formatUrl(.live)) { (data, err) in
            guard err == nil, let data = data else {
                completion(nil, err)
                return
            }
            do {
                let currentQuote: CurrentQuote = try JSONDecoder().decode(CurrentQuote.self, from: data)
                completion(currentQuote, nil)
            } catch let err{
                completion (nil, err.localizedDescription)
            }
        }
    }

    private func request(url: String, completion: @escaping (_ response: Data?, _ error: String? )->Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            guard err == nil else {
                completion(nil, err?.localizedDescription)
                return
            }

            completion(data, nil)
        }.resume()
    }
}


