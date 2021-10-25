//
//  MockCurrencyRepository.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


class MockCurrencyDataSource: CurrencyDatSourceProtocol {
    
    func currenciesAvaliable(success: @escaping (([Currency]) -> Void), fail: @escaping ((String) -> Void)) {
        do {
            let decodedData = try JSONDecoder().decode(CurrencyResposnse.self, from: readLocalFile(forName: "CurrencyList")!)
            var currenciesAvaliable: [Currency] = []
            
            decodedData.currencies.forEach { currency in
                currenciesAvaliable.append(Currency(code: currency.key, name: currency.value))
            }
            
            success(currenciesAvaliable)
            
        } catch {
            fail(error.localizedDescription)
        }
    }
    
    func quotes(success: @escaping (([Quotes]) -> Void), fail: @escaping ((String) -> Void)) {
        do {
            let decodedData = try JSONDecoder().decode(LiveResult.self, from: readLocalFile(forName: "CurrencyLive")!)
            var quotes: [Quotes] = []
            
            decodedData.quotes.forEach { currency in
                quotes.append(Quotes(code: currency.key, quote: currency.value))
            }
            
            success(quotes)
            
        } catch {
            fail("error")
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
