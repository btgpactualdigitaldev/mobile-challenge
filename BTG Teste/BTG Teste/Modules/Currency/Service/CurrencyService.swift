//
//  CurrencyService.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class CurrencyService {
    let baseUrl = "http://api.currencylayer.com/"
    let accessKey = "292da4a633e99b4401b67c7eae7ca708"
    
    func retrieveRemoteCurrencies(completion: @escaping ((CurrencyListResponse?) -> Void))  {
        let urlString = "\(baseUrl)list?access_key=\(accessKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { completion(nil); return }
                completion(try? JSONDecoder().decode(CurrencyListResponse.self, from: data))
        }.resume()
    }
    
    func retrieveRemoteQuotes(completion: @escaping ((CurrencyQuotesResponse?) -> Void))  {
        let urlString = "\(baseUrl)live?access_key=\(accessKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { completion(nil); return }
                completion(try? JSONDecoder().decode(CurrencyQuotesResponse.self, from: data))
        }.resume()
    }
}
