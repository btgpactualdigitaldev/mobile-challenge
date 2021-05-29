//
//  CurrencyTypesService.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 25/11/20.
//

import Foundation

class CurrencyTypesService{
    ///Dictionary that will store all the acronyms and it's name
    var quotes: Dictionary<String, String> = [:]
    ///Array that will store the acronyms
    var acronyms: [String] = []
    ///Array that will store the names
    var currencyNames: [String] = []
    
   
    init() {
        fetchCurrencyTypes()
    }
    
    
    ///Function that will fetch all the currency types with its acronyms
    func fetchCurrencyTypes(){
        let url = "http://api.currencylayer.com/list?access_key=baa8ca67a82137316bb59b665428e101"
        let session = URLSession.shared
        let linkURL = "\(url)"
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
                    
                    self.quotes = (dados["currencies"] as? Dictionary<String, String>)!
                    let sorted = self.quotes.sorted { $0.value < $1.value }
                    let count = sorted.count
                    for i in 0..<(count-1){          
                        self.acronyms.append(sorted[i].key)
                        self.currencyNames.append(sorted[i].value)
                    }
                }
                
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    ///Function that will return the acronyms array
    func sendAcronyms() -> Array<String>{
        return self.acronyms
    }
    ///Function that return the names array
    func sendCurrencyNames() -> Array<String>{
        return self.currencyNames
    }
}
