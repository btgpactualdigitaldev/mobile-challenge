//
//  LiveResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

class LiveResponse: NSObject, Codable, NSCoding {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: Int?
    var source: String?
    var quotes: [String: Double]?
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        
        success = aDecoder.decodeBool(forKey: "success")
        terms = aDecoder.decodeObject(forKey: "terms") as? String
        privacy = aDecoder.decodeObject(forKey: "privacy") as? String
        timestamp = aDecoder.decodeInteger(forKey: "timestamp")
        source = aDecoder.decodeObject(forKey: "source") as? String
        quotes = aDecoder.decodeObject(forKey: "quotes") as? [String: Double]
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(success, forKey: "success")
        aCoder.encode(terms, forKey: "terms")
        aCoder.encode(privacy, forKey: "privacy")
        aCoder.encode(timestamp, forKey: "timestamp")
        aCoder.encode(source, forKey: "source")
        aCoder.encode(quotes, forKey: "quotes")
    }
}
