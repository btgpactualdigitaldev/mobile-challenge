//
//  Requestable.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

protocol Requestable {
    var url: String { get set }
    var method: HttpMethod { get }
    var timeout: TimeInterval { get }
}

// MARK: - Requestable Extension

extension Requestable {

    var method: HttpMethod {
        .get
    }
    
    var timeout: TimeInterval {
        TimeInterval(30)
    }
    
}
