//
//  GetCurrencyUseCase.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

protocol GetCurrencyUseCaseProtocol {
    func getCurrencies(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void)
}

struct GetCurrencyUseCase {
    let repository: CurrencyRepositoryProtocol
}

extension GetCurrencyUseCase: GetCurrencyUseCaseProtocol {
    func getCurrencies(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void) {
        repository.getCurrencies { result in
            completion(result)
        }
    }
}
