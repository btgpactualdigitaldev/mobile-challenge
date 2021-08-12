//
//  NSObject+BuilderChain.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import Foundation

protocol BuilderChain {}

extension BuilderChain where Self: AnyObject {
    @discardableResult
    func set<T>(_ property: ReferenceWritableKeyPath<Self, T>, to value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
    
    @discardableResult
    func run(_ handler: ((Self) -> Void)) -> Self {
        handler(self)
        return self
    }
}

extension NSObject: BuilderChain {}
