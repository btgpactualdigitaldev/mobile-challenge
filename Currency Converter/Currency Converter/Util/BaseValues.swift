//
//  BaseValues.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 30/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit

class BaseValues: NSObject {

    static func getBaseURL() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "baseURL") as! String
    }

    static func getToken() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "token") as! String
    }    
}
