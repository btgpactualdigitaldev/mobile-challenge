//
//  GetCurrencyUseCaseTests.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

import XCTest
@testable import Curriencies

final class CurrencyRepositorySpy: CurrencyRepositoryProtocol {
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

final class GetCurrencyUseCaseTests: XCTestCase {
    let currencyRepositorySpy = CurrencyRepositorySpy()
    lazy var sut = GetCurrencyUseCase(repository: currencyRepositorySpy)
    
    let currencyDummy: [CurrencyEntity] = [
        CurrencyEntity(code: "BRL", name: "Brazilian Real", value: 5),
        CurrencyEntity(code: "ABC", name: "American Dolar", value: 2)
    ]

    func testGetCurrencies_WhenReceiveError_ShouldReturnError() {
        currencyRepositorySpy.setError(.generic)
        
        sut.getCurrencies { [weak self] result in
            switch result {
            case .success(_):
                XCTFail()
            case let .failure(error):
                XCTAssertEqual(error, RepositoryError.generic)
            }
            XCTAssertEqual(self?.currencyRepositorySpy.callGetCurrencies, 1)
        }
    }
    
    func testGetCurrencies_WhenReceiveEntities_ShouldReturnEntities() {
        currencyRepositorySpy.setSuccess(entities: currencyDummy)
        
        sut.getCurrencies { [weak self] result in
            switch result {
            case let .success(entities):
                XCTAssertEqual(entities[0].code, "BRL")
            case .failure(_):
                XCTFail()
            }
            XCTAssertEqual(self?.currencyRepositorySpy.callGetCurrencies, 1)
        }
    }
}
