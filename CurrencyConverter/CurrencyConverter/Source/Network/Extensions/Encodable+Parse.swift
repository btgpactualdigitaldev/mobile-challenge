//
//  Encodable+Parse.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

extension Encodable {

    /// Parse to String dictionary
    ///
    /// - Returns: serializable dictionary
    public func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(
                with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }

    /// Parse to data
    ///
    /// - Returns: data type
    public func asData() -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(Constants.apiDateFormatter)
        let data = try? encoder.encode(self)
        return data
    }
    
}

class Constants {
    static var apiDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        formatter.calendar = Calendar.current
        formatter.locale = Locale.current
        return formatter
    }
}
