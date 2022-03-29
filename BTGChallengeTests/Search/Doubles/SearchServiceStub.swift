//
//  SearchServiceStub.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
import NetworkCore
@testable import BTGChallenge

final class SearchServiceStub: CurrencieProtocol {
    
    var isError: Bool = false
    var result: [String : String] = [:]
    
    func fetchCurrencys(completion: @escaping (Result<[String : String], ErrorsRequests>) -> Void) {
        if !isError {
            completion(.success(result))
        } else {
            completion(.failure(ErrorsRequests.error(error: "Test Error")))
        }
    }
    
}
