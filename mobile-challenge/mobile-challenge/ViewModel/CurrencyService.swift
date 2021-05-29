//
//  CurrencyService.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 25/11/20.
//

import Foundation

class CurrencyService {
    ///Base URL
    let url = "http://api.currencylayer.com/live?access_key=baa8ca67a82137316bb59b665428e101&currencies="

    ///Array of acronyms
    var acronyms: [String] = []
    //Array of values of the currencies(in USD value)
    var currencyValues: [NSNumber] = []
    ///First value in USD
    var num1 = Double()
    ///Second value in USD
    var num2 = Double()
    /// Instance of the Result delegate
    var passResult: PassResultDelegate?
    ///Store the acronym of the first currency
    var firstCurrency: String?
    ///Store the acronym of the second currency
    var secondCurrency: String?
    ///Store the amount that will be converted
    var amount = 0.0
    
    
    
    init(firstCurrency:String, secondCurrency: String, amount: Double) {
        fetch(firstCurrency: firstCurrency, secondCurrency: secondCurrency, amount: amount)
    }
    ///Function that fetches the values of the currencies requested.
    func fetch(firstCurrency:String, secondCurrency: String, amount: Double){
        
        let session = URLSession.shared
        let linkURL = "\(url)\(firstCurrency),\(secondCurrency)"
        let urlApi = URL(string: linkURL)!

        let task = session.dataTask(with: urlApi) {data, response, error in
            guard error == nil else {
                print("Ocorreu um erro. \(String(describing: error))")
                return
            }
            
            var json: Any!
            do{
                json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let dados = json as? [String:Any]{
                    let quotes = (dados["quotes"] as! Dictionary<String, NSNumber>)

                    self.acronyms = Array(quotes.keys)
                    self.currencyValues = Array(quotes.values)
                    self.num1 = Double(self.currencyValues[0])
                    self.num2 = Double(self.currencyValues[1])
                    let res = self.convert(num1: self.num1, num2: self.num2, amount: amount)
                    self.passResult?.passResult(result: res)
                }
                
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    
    ///Function that return the value of the first currency in dolar
    func getValue1() -> Double{
        print(num1)
        return self.num1
    }
    ///Function that return the value of the second currency in dolar
    func getValue2() -> Double{
        return self.num2
    }
    ///Function that converts the value to the other currency and multiplies the amount requested
    func convert(num1:Double, num2:Double, amount: Double) -> Double{
        var result = ((num1)/(num2))*amount
        return result
    }

}
