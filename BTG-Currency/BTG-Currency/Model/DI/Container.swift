//
//  Container.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public typealias Resolver = Container

public class Container {
    private var content: [String: Any] = [:]
    public static var shared: Container = Container()
    
    private init() {}
    
    public func register<Object: Any>(_ objectType: Object.Type, object: @escaping (Resolver) -> Object) {
        content[String(describing: Object.self)] = object(self)
    }
    
    public func resolve<Object: Any>(_ objectType: Object.Type) -> Object? {
        content[String(describing: Object.self)] as? Object
    }
    
    public func remove<Object: Any>(_ objectType: Object.Type) {
        content.removeValue(forKey: String(describing: Object.self))
    }
}

extension Container: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
