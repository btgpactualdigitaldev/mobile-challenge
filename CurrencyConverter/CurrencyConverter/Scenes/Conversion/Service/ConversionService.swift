//
//  ConversionService.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 17/07/22.
//

import Foundation

protocol ConversionServiceProtocol {
    typealias QuotationLiveResult = Result<QuotationLive, ServiceError>
    func fetchQuotationLive(completion: @escaping (QuotationLiveResult) -> Void)
}

class ConversionServiceDefault: ConversionServiceProtocol {
    
    private var networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()
    
    func fetchQuotationLive(completion: @escaping (QuotationLiveResult) -> Void) {
        networkDispatcher.request(endpoint: .live) { result in
            switch result {
            case .success(let data):
                do {
                    let cotation = try JSONDecoder().decode(QuotationLive.self, from: data)
                    completion(.success(cotation))
                } catch {
                    completion(.failure(ServiceError.parseError))
                }
            
            case .failure(let err):
                completion(.failure(ServiceError.networkError(err.localizedDescription)))
            }
        }
    }
}
