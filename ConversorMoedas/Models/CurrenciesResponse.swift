//
//  CurrenciesList.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 12/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

class CurrenciesList {
    
    func getList(_ callback: @escaping CallBack, _ errorCallBack: @escaping ErrorCallBack){
        
        
        let urlRequest = APIManager().getListURL()
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                errorCallBack("Falha de conexão")
                return
            }
 
            var result: RequestResponse?
            do {
                result = try JSONDecoder().decode(RequestResponse.self, from: data)
                
                //let realData = data
                guard let currenciesList = result?.currencies else {return}
                callback(currenciesList)
            }
            catch {
                errorCallBack("falha na conversão \(error.localizedDescription)")
            }
        })
        task.resume()
    }

    struct RequestResponse: Codable {
        let success: Bool
        let terms: String
        let privacy: String
        let currencies: [String:String]
    }
    
    struct Currencies: Codable {
        let key: String
        let value: String
    }
    
    typealias CallBack = ([String:String]) -> ()
    typealias ErrorCallBack = (Error) -> ()
}

