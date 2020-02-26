//
//  IsoCountryInfo.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 20/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Foundation

public struct IsoCountryInfo {
    
    public let name: String
    public let numeric: String
    public let alpha2: String
    public let alpha3: String
    public let calling: String
    public let currency: String
    public let continent: String
    public var flag: String? {
        return IsoCountries.flag(countryCode: alpha2)
    }
}

public class IsoCountries {
    
    public class func flag(countryCode: String) -> String? {
        var string = ""
        let country = countryCode.uppercased()
        
        let regionalA = "🇦".unicodeScalars
        let letterA = "A".unicodeScalars
        let base = regionalA[regionalA.startIndex].value - letterA[letterA.startIndex].value
        
        for scalar in country.unicodeScalars {
            guard let regionalScalar = UnicodeScalar(base + scalar.value) else { return nil }
            string.unicodeScalars.append(regionalScalar)
        }
        return string.isEmpty ? nil : string
    }
    
    public class func flag(currencyCode: String) -> String? {
        var string = ""
        let currency = currencyCode.uppercased()
        
        let regionalA = "🇦".unicodeScalars
        let letterA = "A".unicodeScalars
        let base = regionalA[regionalA.startIndex].value - letterA[letterA.startIndex].value
        
        for scalar in currency.unicodeScalars {
            guard let regionalScalar = UnicodeScalar(base + scalar.value) else { return nil }
            string.unicodeScalars.append(regionalScalar)
        }
        return string.isEmpty ? nil : string
    }
    
}
