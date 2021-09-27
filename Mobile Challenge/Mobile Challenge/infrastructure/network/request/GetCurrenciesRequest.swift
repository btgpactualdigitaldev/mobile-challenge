//
//  GetCurrenciesRequest.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

struct GetCurrenciesRequest: Requestable {
    var url: String = ApiResource.listCurrencies.rawValue
}
