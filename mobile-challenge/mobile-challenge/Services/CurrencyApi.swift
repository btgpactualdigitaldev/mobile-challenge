//
//  CurrencyApi.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 25/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import Foundation

class CurrencyApi {
    // MARK: - Api Attributes
    fileprivate let baseUrl: String = "http://api.currencylayer.com/"
    fileprivate let accessKey: String = "?access_key=e9d1398860ea67da1b01f70f1d7e1dcc"
    
    public func getCurrencyList(escaping: @escaping ([Currency]?) -> Void) {
        // MARK: Session Config
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfig)
        let url = URL(string: "\(baseUrl)list\(accessKey)")!
        
        // MARK: Request Config
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                escaping(nil)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode != 200 {
                        print("## error, httpStatus == \(statusCode) ##")
                        escaping(nil)
                    } else {
                        do {
                            if let data = data {
                                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                if let dict = json as? [String: AnyObject] {
                                    if let currencies = dict["currencies"] as? [String: String] {
                                        var currencyList: [Currency] = []
                                        for (key, value) in currencies {
                                            currencyList.append(Currency(symbol: key, name: value))
                                        }
                                        currencyList.sort(by: { (firstCurrency, secondCurrency) -> Bool in
                                            return firstCurrency.name < secondCurrency.name
                                        })
                                        escaping(currencyList)
                                    }
                                }
                            }
                        } catch {
                            print("## getCurrencyList error ##")
                            escaping(nil)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    public func getCurrencyListConvertedToDollar(escaping: @escaping ([CurrencyDollarValue]?) -> Void) {
        // MARK: Session Config
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfig)
        let url = URL(string: "\(baseUrl)live\(accessKey)")!
        
        // MARK: Request Config
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                escaping(nil)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode != 200 {
                        print("## error, httpStatus == \(statusCode) ##")
                        escaping(nil)
                    } else {
                        do {
                            if let data = data {
                                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                if let dict = json as? [String: AnyObject] {
                                    if let currencies = dict["quotes"] as? [String: Double] {
                                        var convertedCurrencylist: [CurrencyDollarValue] = []
                                        for (key, value) in currencies {
                                            convertedCurrencylist.append(CurrencyDollarValue(symbol: key, dollarQuotation: value))
                                        }
                                        escaping(convertedCurrencylist)
                                    }
                                }
                            }
                        } catch {
                            print("## getCurrencyListConvertedToDollar error ##")
                            escaping(nil)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
