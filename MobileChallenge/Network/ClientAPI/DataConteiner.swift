//
//  DataConteiner.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}
