//
//  API.swift
//  Desafio_BTG
//
//  Created by Kleyson on 10/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import Foundation

final class API {
    static func fetchQuotes(completion: @escaping(Quotes) -> Void, completionError: @escaping(String) -> Void) {
        guard let url  = URL(string: Endpoints.live + getPrivateKey()) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let quotes = try JSONDecoder().decode(Quotes.self, from: data)
                    DispatchQueue.main.async {
                        completion(quotes) //retornar o model desta funcão
                    }
                } catch {
                    completionError("Ocorreu um erro!")
                }
            }
            else {
                completionError("Erro de conexão")
            }
        }
        task.resume() //da o play na task assincrona
    }
    
    static func fetchList(completion: @escaping(List) -> Void, completionError: @escaping(String) -> Void) {
        guard let url  = URL(string: Endpoints.list + getPrivateKey()) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let list = try JSONDecoder().decode(List.self, from: data)
                    DispatchQueue.main.async {
                        completion(list) //retornar o model desta funcão
                    }
                } catch {
                    completionError("Ocorreu um erro!")
                }
            }
            else {
                completionError("Erro de conexão")
            }
        }
        task.resume() //da o play na task assincrona
    }
    
    private static func getPrivateKey() -> String {
        return "?access_key=468271e2e3bdfdd307feb8fd8ffa7cd9"
    }
    
}
