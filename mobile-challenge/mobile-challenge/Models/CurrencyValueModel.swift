//
//  CurrencyModel.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 24/04/21.
//

import Foundation

public struct CurrencyValueModel: Codable {
    public var quotes: Quotes
    
}

public struct Quote: Codable {
    public var key: String = ""
    public var value: Double = 0.0
}


public struct Quotes: Codable {
    public var array: [Quote]
    
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

        var tempArray = [Quote]()

        
        // Loop through each key (student ID) in container
        for key in container.allKeys {
            let value = try container.decode(Double.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            var quote = Quote()
            quote.value = value
            quote.key = key.stringValue
            tempArray.append(quote)
        }
        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        array = tempArray
    }
    
    
}
