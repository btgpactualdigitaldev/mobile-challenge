//
//  Box.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

/**
 Simple Box class for reactive programming.
 It holds one listener (observer) that is bound to the objects and updates accordinly
 */
class Box<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /// binds the closure to the value and calls the listener right away to be updated
    func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
}
