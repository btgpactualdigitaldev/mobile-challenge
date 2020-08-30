//
//  Quote.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 30/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire

class Quote: Object {

    @objc dynamic var objectId: String? = nil
    override static func primaryKey() -> String? {
        return "objectId"
    }

    @objc dynamic var fromCurrency: String? = nil
    @objc dynamic var toCurrency: String? = nil
    @objc dynamic var dollarRatio = 0 as Double
    @objc dynamic var date: Date? = nil

    class func createOrUpdateFromJSON(_ key: String, _ json: JSON, realm: Realm) -> Quote? {
        
        if let localObject = realm.object(ofType: Quote.self, forPrimaryKey: key) {
            localObject.update(json)
            return localObject
        } else {
            let object = Quote()
            object.objectId = key
            realm.add(object)
            object.update(json)
            return object
        }
    }
    
    func update(_ json: JSON) {
        
        fromCurrency = String(objectId!.prefix(3))
        toCurrency = String(objectId!.suffix(3))
        dollarRatio = json.doubleValue
        date = Date()
    }
    
    func lastUpdate() -> String? {
        
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "Última atualização em dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func isUpToDate() -> Bool {
        
        if let date = date {
            let today = Date()
            return Calendar.current.isDate(date, inSameDayAs:today)
        }
        
        return false
    }
    
    static func getQuote(toCurrency: String, callback: @escaping (_ target: String?, _ error: NSError?) -> Void) {
        
        AF.request("http://" + BaseValues.getBaseURL() + "/live?access_key=" + BaseValues.getToken() + "&currencies=" + toCurrency + "&source=USD&format=1",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    
                    let json = JSON(value)
                    let realm = try! Realm()
                    
                    try! realm.write {
                        for (key, subJson) in json["quotes"] {
                            
                            let quote = Quote.createOrUpdateFromJSON(key, subJson, realm: realm)
                            let currency = realm.object(ofType: Currency.self, forPrimaryKey: quote?.toCurrency)
                            currency?.updating = false
                            currency?.quoteExists = true
                        }
                        
                        try! realm.commitWrite()
                    }
                
                    callback("success", nil)

                case .failure(let error as NSError):
                    print(error)
                    let code = response.response != nil ? response.response!.statusCode : error.code
                    callback(nil, error.parsedErrorForHTTPStatusCode(code))
                default: break
            }
        }
    }
}
