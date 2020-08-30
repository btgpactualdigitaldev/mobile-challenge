//
//  Currency.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class Currency: Object {

    @objc dynamic var shortName: String? = nil
    override static func primaryKey() -> String? {
        return "shortName"
    }
    
    @objc dynamic var longName: String? = nil
    @objc dynamic var quoteId: String? = nil
    @objc dynamic var updating = false
    @objc dynamic var quoteExists = false

    // This variable exists to allow for an offline database to be built,
    // while still removing currencies in case it ceases to return or ceases to exist
    @objc dynamic var active: Bool = true
    
    class func createIfNeeded(_ key: String, realm: Realm) -> Currency? {
        
        if let localObject = realm.object(ofType: Currency.self, forPrimaryKey: key) {
            return localObject
        } else {
            let object = Currency()
            object.shortName = key
            object.quoteId = "USD" + key
            realm.add(object)
            return object
        }
    }

    class func createOrUpdateFromJSON(_ key: String, _ json: JSON, realm: Realm) -> Currency? {
        
        if let localObject = realm.object(ofType: Currency.self, forPrimaryKey: key) {
            localObject.update(json)
            return localObject
        } else {
            let object = Currency()
            object.shortName = key
            realm.add(object)
            object.update(json)
            return object
        }
    }
    
    func update(_ json: JSON) {
        longName = json.string
        active = true
        quoteId = "USD" + shortName!
    }
    
    func updateNameForShort() {
        if shortName == "USD" {
            longName = "United States Dollar"
        } else {
            longName = "Brazilian Real"
        }
    }
    
    func isUpToDate(callback: @escaping (_ target: String?, _ error: NSError?) -> Void) -> Bool {
        
        let realm = try! Realm()
        
        let quote = realm.object(ofType: Quote.self, forPrimaryKey: quoteId)
                
        if let quote = quote {
            if (quote.isUpToDate()) {
                return true
            }
        }
                
        if (!updating) {
            try! realm.write {
                updating = true
                try! realm.commitWrite()
            }
            
            Quote.getQuote(toCurrency: shortName!, callback: callback)
        }
        
        return false
    }
}

extension Currency {
    
    static func listCurrencies(callback: @escaping (_ currencies: [Currency]?, _ error: NSError?) -> Void) {
                
        AF.request("http://" + BaseValues.getBaseURL() + "/list?access_key=" + BaseValues.getToken(),
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
                        
                        let localList = realm.objects(Currency.self)
                        for (currency) in localList {
                            currency.active = false
                        }
                        
                        var currencies = [Currency]()
                        
                        for (key, subJson) in json["currencies"] {
                            if let aCurrency = Currency.createOrUpdateFromJSON(key, subJson, realm: realm) {
                                currencies.append(aCurrency)
                            }
                        }
                        
                        try! realm.commitWrite()
                        callback(currencies, nil)
                    }

                case .failure(let error as NSError):
                    print(error)
                    let code = response.response != nil ? response.response!.statusCode : error.code
                    callback(nil, error.parsedErrorForHTTPStatusCode(code))
                default: break
            }
        }
    }
}
