//
//  Array+FuzzySearchable.swift
//  Screens
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine

extension Array {
    func search<Value>(for text: String, at properties: (name: KeyPath<Element, Value>, weight: Double)...) -> Future<[Element], Never> where Value: CustomStringConvertible {
        
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                promise(.success(self.searched(for: text, at: properties)))
            }
        }
    }
    
    private func searched<Value>(for text: String, at properties: [(name: KeyPath<Element, Value>, weight: Double)]) -> [Element] where Value: CustomStringConvertible {
        let properties = map { element in
            (element: element, properties: properties.map { property in (name: element[keyPath: property.name], weight: property.weight) })
        }
        let scores = properties
            .map { tuple -> (element: Element, properties: [Double]) in
                (element: tuple.element,
                 properties: tuple.properties.map { $0.name.description.score(word: text) * $0.weight })
        }
        let bestConfidence = scores.map { tuple in (element: tuple.element, properties: tuple.properties.compactMap { $0 }.max() )}
        let nonNil = bestConfidence.compactMap { $0.properties == nil ? nil : (element: $0.element, property: $0.properties! )}
        let sorted = nonNil.sorted { $0.property > $1.property }
        return sorted.filter { $0.property > 0.0 }.map { $0.element }
    }
}
