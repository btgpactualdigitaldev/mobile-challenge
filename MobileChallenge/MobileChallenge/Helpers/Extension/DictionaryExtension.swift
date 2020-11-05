//
//  DictionaryExtension.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
