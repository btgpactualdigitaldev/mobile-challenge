//
//  Loader.swift
//  ConverterCurrencyBTGTests
//
//  Created by Thiago Vaz on 06/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class Loader {
    
    @discardableResult
    static func mock<T: Codable>(file: String) -> T? {
        guard let data = loadFile(with: file),
            let result = try? JSONDecoder().decode(T.self, from: data) else {
                return nil
        }
        return result
    }
    
    static func loadFile(with name: String) -> Data? {
        guard let urlPath = Bundle(for: Loader.self).path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: urlPath), options: .mappedIfSafe) else {
                return nil
        }
        return data
    }
}
