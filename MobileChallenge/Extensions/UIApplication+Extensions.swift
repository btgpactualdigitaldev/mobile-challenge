//
//  UIApplication+Extensions.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import UIKit

extension UIApplication {
    static var urlRoot: String {
        return Bundle.main.object(forInfoDictionaryKey: "urlRoot") as? String ?? ""
    }
    
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String ?? ""
    }
}
