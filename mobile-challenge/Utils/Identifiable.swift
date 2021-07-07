//
//  Identifiable.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 27/09/20.
//

import Foundation

protocol Identifiable: AnyObject {
    static var uniqueIdentifier: String { get }
}

extension Identifiable {
    static var uniqueIdentifier: String {
        String(describing: self)
    }
}
