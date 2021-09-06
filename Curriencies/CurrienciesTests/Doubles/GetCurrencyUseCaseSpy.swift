//
//  GetCurrencyUseCaseSpy.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

@testable import Curriencies

final class GetCurrencyUseCaseSpy: GetCurrencyUseCaseProtocol {
    private(set) var callGetCurrencies = 0
    
    private var entities: [CurrencyEntity] = []
    private var error: RepositoryError?
    
    func setSuccess(entities: [CurrencyEntity]) {
        self.entities = entities
    }
    
    func setError(_ error: RepositoryError) {
        self.error = error
    }
    
    func getCurrencies(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void) {
        callGetCurrencies += 1
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(entities))
        }
    }
}
