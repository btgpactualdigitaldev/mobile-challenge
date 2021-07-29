//
//  RequestProvidingProtocol.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}
