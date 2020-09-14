//
//  MainService.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

struct Host {
    static let keyAccess = "a1f0a537b496a92aae748786ac0e57d2"
    static let urlString = "http://api.currencylayer.com"
}

protocol MainServiceDelegate {
    
}

class MainService {
    
    var viewModel: MainViewModelDelegate?
    
    func getQuotesCurrency(in endpoint: String = "\(Host.urlString)/live?access_key=\(Host.keyAccess)") {
        let url = URL(string: endpoint)
        guard let urlEndpoint = url else { return }
        var request = URLRequest(url: urlEndpoint)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let quotes = try? JSONDecoder().decode(Live.self, from: data)
                if let quotes = quotes { self.viewModel?.didGetQuotesCurrency(quotes) }
            } else if let error = error {
                print("Error: \(error)")
            } else {
                
            }
        }
        
        task.resume()
    }
}
