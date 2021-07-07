//
//  ConvertViewModel.swift
//  Currency Converter
//
//  Created by Otávio Souza on 29/09/20.
//

import UIKit

class ConvertViewModel: NSObject {
    let dataManager = DataManager()
}

extension ConvertViewModel {
    
    func convert(value:Double, from: String, to: String,completion: @escaping (Result<Double, Error>) -> Void){
        fetchLive(unit: from, completion: { (resultFrom) in
            switch resultFrom {
            case .failure(let error):
                completion(.failure(error))
            case .success(let dataFrom):
                self.fetchLive(unit: to, completion: { (resultTo) in
                    self.save(quotes: dataFrom.quotes)
                    let valueFromReceived = dataFrom.quotes.filter { (item) -> Bool in
                        return item.key.dropFirst(3).contains(from)
                    }
                    let valueToReceived = dataFrom.quotes.filter { (item) -> Bool in
                        return item.key.dropFirst(3).contains(to)
                    }
                    if let valueFrom = valueFromReceived.first?.value,
                       let valueTo = valueToReceived.first?.value {
                        let calculateFinal = self.calculate(valueIn: value, convertionFrom: valueFrom, convertionTo: valueTo);
                        completion(.success(calculateFinal))
                    }
                })
            }
        })
    }
    
    func save(quotes: Dictionary<String, Double>)  {
        let dataManager = DataManager()
        var quotesCopy = [Dictionary<String, Double>.Element]()
        
        let sorted = quotes.sorted(by: < )
        sorted.forEach { (item) in
            quotesCopy.append(contentsOf: [String(item.key.dropFirst(3)) : item.value])
        }
        dataManager.save(quoteList:quotesCopy)
    }
    
    func convertFromBackup(value:Double, from: String, to: String) -> Double {
        let quotesFromBackup = dataManager.loadAllQuotes()
        let valueFromReceived = quotesFromBackup.filter { (item) -> Bool in
            return item.key.contains(from)
        }
        let valueToReceived = quotesFromBackup.filter { (item) -> Bool in
            return item.key.contains(to)
        }
        if let valueFrom = valueFromReceived.first?.value,
           let valueTo = valueToReceived.first?.value {
            let calculateFinal = self.calculate(valueIn: value, convertionFrom: valueFrom, convertionTo: valueTo);
            return calculateFinal
        }
        return -1
        
    }
    
    func calculate(valueIn: Double, convertionFrom: Double, convertionTo: Double) -> Double {
        let convertedToDolar = valueIn / convertionFrom
        let convertedToFinal = convertedToDolar * convertionTo
        return convertedToFinal;
    }
    
    func fetchLive(unit: String, completion: @escaping (Result<LiveModel, Error>) -> Void) {
        var url = URL(string: baseUrl + live)!
        url.appendQueryItem(name: acess_key, value: apiKey)
        
        ConnectionManager.shared.get(urlString: url.absoluteString, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data) :
                let decoder = JSONDecoder()
                do {
                    let liveModel = try decoder.decode(LiveModel.self, from: data)
                    completion(.success(liveModel))
                } catch {
                    do {
                        let result2 = try decoder.decode(ErrorModel.self, from: data)
                        completion(.failure(result2.error))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        })
    }
    
}
