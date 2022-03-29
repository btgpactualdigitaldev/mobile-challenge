//
//  BTGService.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import NetworkCore

protocol CurrencieProtocol {
    func fetchCurrencys(completion: @escaping (Result<[String : String], ErrorsRequests>) -> Void)
}

class CurrencieService: CurrencieProtocol {
    
    let service = NetworkTasks<Currencies>()
    
    func fetchCurrencys(completion: @escaping (Result<[String : String], ErrorsRequests>) -> Void) {
        service.execute(
            connection: ConnectionList()
        ) { result in
            switch result {
            case .success(let list):
                if let listCurrencies = list?.currencies {
                    completion(.success(listCurrencies))
                } else {
                    completion(.failure(.errorDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
