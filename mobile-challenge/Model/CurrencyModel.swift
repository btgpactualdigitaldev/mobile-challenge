//
//  CurrencyModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

class CurrencyModel: NSObject, NSCoding, Decodable, Identifiable {
    let code: String
    let name: String
    var valueDollar: Double?
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        code = coder.decodeObject(forKey: Identifier.CurrencyModel.code.rawValue) as? String ?? ""
        name = coder.decodeObject(forKey: Identifier.CurrencyModel.name.rawValue) as? String ?? ""
        valueDollar = coder.decodeObject(forKey: Identifier.CurrencyModel.valorDollar.rawValue) as? Double ?? 0
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(code, forKey: Identifier.CurrencyModel.code.rawValue)
        coder.encode(name, forKey: Identifier.CurrencyModel.name.rawValue)
        coder.encode(valueDollar, forKey: Identifier.CurrencyModel.valorDollar.rawValue)
    }
    
}
