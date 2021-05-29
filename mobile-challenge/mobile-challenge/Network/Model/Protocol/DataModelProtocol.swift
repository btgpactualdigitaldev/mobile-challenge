//
//  DataModelProtocol.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

protocol DataModelProtocol: Decodable {
    static var service: ServiceType { get }
}
