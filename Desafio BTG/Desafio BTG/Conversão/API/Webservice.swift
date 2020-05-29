//
//  Webservice.swift
//  Desafio BTG
//
//  Created by Vinícius Brito on 24/05/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Config {
    
    // MARK: - <Endpoints>
 
    static func baseUrl() -> String {
        let url = "http://api.currencylayer.com/"
        return url
    }
    
    /*
     Return the most recent exchange rate data.
     */
    static func live() -> String {
        let url = "live"
        return url
    }
    
    /*
     Return the list of currencies.
     */
    static func list() -> String {
        let url = "list"
        return url
    }
    
    // MARK: - <Properties>
    
    static func access_key() -> String {
        let access_key = "8967ed355fa883b17038b3566ada7344"
        return access_key
    }
    
}

class Webservice {
    
    /*
    Get the list of currencies.
    */
    class func getCurrenciesList(completion: @escaping (Bool, JSON?) -> ()) {
                
        let url = "\(Config.baseUrl())\(Config.list())"
    
    let parameters : Parameters = [
        "access_key": Config.access_key()]
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
        (response) in
        
            switch response.result {
            case .success:
                if let value = response.result.value {
                    /*
                     Handling API Errors.
                     */
                    switch response.response?.statusCode {
                    case 404:
                        print("User requested a resource which does not exist.")
                    case 101:
                        print("User did not supply an access key or supplied an invalid access key.")
                    case 103:
                        print("User requested a non-existent API function.")
                    case 104:
                        print("User has reached or exceeded his subscription plan's monthly API request allowance.")
                    case 105:
                        print("The user's current subscription plan does not support the requested API function.")
                    case 106:
                        print("The user's query did not return any results.")
                    case 102:
                        print("The user's account is not active. User will be prompted to get in touch with Customer Support.")
                    case 201:
                        print("User entered an invalid Source Currency.")
                    case 202:
                        print("User entered one or more invalid currency codes.")
                    default:
                        break
                    }
                
                    let json = JSON(value)
                    completion(json.dictionary != nil, json)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    /*
     Get the most recent exchange data.
     */
    class func getLive(completion: @escaping (Bool, JSON?) -> ()) {
                
        let url = "\(Config.baseUrl())\(Config.live())"
    
        let parameters : Parameters = [
        "access_key": Config.access_key()]
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
        (response) in
        
            switch response.result {
            case .success:
                if let value = response.result.value {
                    /*
                     Handling API Errors.
                     */
                    switch response.response?.statusCode {
                    case 404:
                        print("User requested a resource which does not exist.")
                    case 101:
                        print("User did not supply an access key or supplied an invalid access key.")
                    case 103:
                        print("User requested a non-existent API function.")
                    case 104:
                        print("User has reached or exceeded his subscription plan's monthly API request allowance.")
                    case 105:
                        print("The user's current subscription plan does not support the requested API function.")
                    case 106:
                        print("The user's query did not return any results.")
                    case 102:
                        print("The user's account is not active. User will be prompted to get in touch with Customer Support.")
                    case 201:
                        print("User entered an invalid Source Currency.")
                    case 202:
                        print("User entered one or more invalid currency codes.")
                    default:
                        break
                    }
                
                    let json = JSON(value)
                    completion(json.dictionary != nil, json)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
}
