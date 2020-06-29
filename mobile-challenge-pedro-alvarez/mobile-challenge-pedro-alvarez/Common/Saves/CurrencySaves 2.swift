//
//  CurrencyConvertionSaves.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

enum CurrencySavesFile: String {
    case convertions = "convertions.json"
    case list = "list.json"
}

class CurrencySaves {
    
    static var shared = CurrencySaves()
    
    private static let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    private init() { }
    
    func save(data: Data, file: CurrencySavesFile) {
        let url = fileURL(byName: file.rawValue)
        do {
            try data.write(to: url)
        } catch {
            
        }
    }
    
    func retrieve(file: CurrencySavesFile) -> Data? {
        let url = fileURL(byName: file.rawValue)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    private func fileURL(byName name: String) -> URL {
        return URL(fileURLWithPath: CurrencySaves.dir.appendingPathComponent(name))
    }
}
