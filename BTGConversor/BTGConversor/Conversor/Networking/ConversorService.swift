//
//  ConversorService.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/14/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

final class ConversorService: Service<ConversorApi> {
    
    func fetchQuota(completion: @escaping (Result<CurrencyLiveQuotas, BTGError>) -> Void) {
        fetch(.liveQuota, dataType: CurrencyLiveQuotas.self) { (result, response) in
            completion(result)
        }
    }
    
    func fetchCurrencies(completion: @escaping (Result<Currencies, BTGError>) -> Void) {
        fetch(.list, dataType: Currencies.self) { (result, response) in
            completion(result)
        }
    }
}
