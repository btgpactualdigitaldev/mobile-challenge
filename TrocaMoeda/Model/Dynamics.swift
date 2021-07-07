//
//  Dynamics.swift
//  TrocaMoeda
//
//  Created by mac on 25/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

class Dynamics<T> {
    typealias CompletionCallback = ((T) -> Void)
    
    var value: T {
        didSet {
            self.notify()
        }
    }
    
    var observers = [String: CompletionCallback]()
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: NSObject, completionCallback: @escaping CompletionCallback){
        observers[observer.description] = completionCallback
    }
    
    func addAndNotify(observer: NSObject, completionCallback: @escaping CompletionCallback) {
        self.addObserver(observer, completionCallback: completionCallback)
        self.notify()
    }
    
    func notify() {
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
    }
}
