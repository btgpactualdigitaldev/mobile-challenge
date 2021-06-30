//
//  Dictionary+URLQueryItems.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

extension Dictionary {
    func queryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = [URLQueryItem]()
        
        for pair in self.enumerated() {
            items.append(URLQueryItem(name: "\(pair.element.key)", value: "\(pair.element.value)"))
        }
        
        return items
    }
}
