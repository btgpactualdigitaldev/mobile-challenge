//
//  CurrencyRepositoryProtocol.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


protocol CurrencyDatSourceProtocol {
    func quotes(success: @escaping (([Quotes]) -> Void), fail: @escaping ((String) -> Void))
    func currenciesAvaliable(success: @escaping (([Currency]) -> Void), fail: @escaping ((String) -> Void))
}
