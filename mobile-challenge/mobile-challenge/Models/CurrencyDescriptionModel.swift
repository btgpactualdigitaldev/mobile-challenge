//
//  CurrencyModel.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 24/04/21.
//

import Foundation

public struct CurrencyNameModel: Codable {
    public var currencies: CurrencyNames
    
}

public struct CurrencyDescription: Codable {
    public var key: String = ""
    public var name: String = ""
}


public struct CurrencyNames: Codable {
    public var array: [CurrencyDescription]
    
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {

        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [CurrencyDescription]()

        
        // Loop through each key (student ID) in container
        for key in container.allKeys {
            let value = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            var currency = CurrencyDescription()
            currency.name = value
            currency.key = key.stringValue
            tempArray.append(currency)
        }

        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        array = tempArray
    }
    
    
}
