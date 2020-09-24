//
//  Cotacao.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

class Exchange {
    
    func getLive(_ currencyKeyOrigin:String, _ currencyKeyDestiny:String, _ valueToConvert:Double, _ callBack: @escaping CallBack, _ errorCallBack: @escaping ErrorCallBack) {
        
        let urlRequest = APIManager().getLiveURL(currencyKeyOrigin, currencyKeyDestiny, valueToConvert)
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                errorCallBack("Falha na conexão")
                return
            }
            
            var result: ConversorLive?
            do {
                result = try JSONDecoder().decode(ConversorLive.self, from: data)
                
                let keyChoiceOrigin = "USD\(currencyKeyOrigin)"
                let keyChoiceDestiny = "USD\(currencyKeyDestiny)"
                
                let dollarOrigin = result?.quotes[keyChoiceOrigin] ?? 0.0
                let dollarDestiny = result?.quotes[keyChoiceDestiny] ?? 0.0
             
                let resultConvert = CurrencyConverter().convertToSelectedCurrency(dollarOrigin, dollarDestiny, valueToConvert)
                
                callBack(resultConvert)
            }
            catch {
               errorCallBack("falha na conversão \(error.localizedDescription)")
            }
        })
        task.resume()
    }

    struct ConversorLive: Codable {
        let success: Bool
        let terms: String
        let privacy: String
        let timestamp: Int
        let source: String
        let quotes: [String: Double]
    }

    typealias CallBack = (Double) -> ()
    typealias ErrorCallBack = (Error) -> ()
}
