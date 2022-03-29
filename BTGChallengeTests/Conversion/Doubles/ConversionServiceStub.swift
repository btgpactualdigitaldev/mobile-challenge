//
//  ConversionServiceStub.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
import NetworkCore
@testable import BTGChallenge

final class ConversionServiceStub: QuotesProtocol {
    
    var isError: Bool = false
    var result: [String : Double] = [:]
    
    func fetchQuotes(completion: @escaping (Result<[String : Double], ErrorsRequests>) -> Void) {
        if !isError {
            completion(.success(result))
        } else {
            completion(.failure(ErrorsRequests.error(error: "Test Error")))
        }
    }
    
}
