//
//  GetCurrentDollarQuoteRequest.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

struct GetCurrentDollarQuoteRequest: Requestable {
    var url: String = ApiResource.currentDollarQuote.rawValue
}

