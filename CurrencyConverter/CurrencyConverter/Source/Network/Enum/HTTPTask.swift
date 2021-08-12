//
//  HTTPTask.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

public typealias Parameters = [String: String]

public enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
    case requestWithBody(Encodable)
}
