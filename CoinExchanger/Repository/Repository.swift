//
//  Repository.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import Foundation

// Eu usaria Alamofire para construir uma biblioteca de funções para facilitar o uso
// e manutenção do código, porém o desafio proposto consiste em não utilizar código
// externo

class Repository {
    static let db = "https://btg-mobile-challenge.herokuapp.com"
    
    // MARK: Get Coins
    ///  Fetch all coins from the server
    class func getCoins(completion: @escaping (GetCoinsResponse?, Error?)->Void) {
        guard let url = URL(string: db.appending("/list")) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
            else { DispatchQueue.main.async() { completion(nil, nil) } ; return }
            
            do {
                let coins = try JSONDecoder().decode(GetCoinsResponse.self, from: data)
                DispatchQueue.main.async() { completion(coins, nil) }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async() { completion(nil, error) }
            }
        }.resume()
    }
    
    // MARK: Get Quotes
    ///  Fetch all coins from the server
    class func getQuotes(completion: @escaping (GetRatesResponse?, Error?)->Void) {
        guard let url = URL(string: db.appending("/live")) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
            else { DispatchQueue.main.async() { completion(nil, nil) } ; return }
            
            do {
                let quotes = try JSONDecoder().decode(GetRatesResponse.self, from: data)
                DispatchQueue.main.async() { completion(quotes, nil) }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async() { completion(nil, error) }
            }
        }.resume()
    }
}
