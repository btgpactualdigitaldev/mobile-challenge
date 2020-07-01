//
//  Utils.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import Foundation

class Utils {
    
    static func loadJsonToModel<T: Codable>(with json: String) -> T? {
        do {
            let data: Data = Utils.loadJsonToData(with: json)!
            let models = try JSONDecoder().decode(T.self, from: data)
            return models
        } catch {
            return nil
        }
    }
    
    static func loadJsonToData(with json: String) -> Data? {
        if let path: String = Bundle(for: self).path(forResource: json, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    static func createSession(with json: String,
                              statusCode: Int,
                              error: Error?) -> URLSessionMock? {

        let data = Utils.loadJsonToData(with: json)
        let response = HTTPURLResponse(url: URL(string: "urlMock")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        return URLSessionMock(completionHandler: (data, response, error))
    }
}
