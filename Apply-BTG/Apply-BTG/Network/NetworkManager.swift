//
//  NetworkManager.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation
import SystemConfiguration

typealias currenciesListCompletion = ([Currency]?) -> Void
typealias conversionListCompletion = (ConversionQuotes?) -> Void

struct NetworkManager {
    func hasInternetConnection() -> Bool {
        return InternetTest().isConnected()
    }
    
    func canCreateAValidURL(from urlString: String) -> Bool {
        return URL(string: urlString) != nil
    }
    
    func fetchCurrenciesList(completion: @escaping currenciesListCompletion) {
        if canCreateAValidURL(from: Constants.BTG_LIST_ENDPOINT) {
            let safeUrl = URL(string: Constants.BTG_LIST_ENDPOINT)!
            
            let task = URLSession.shared.dataTask(with: safeUrl) { data, response, error in
                if let _ = error {
                    print("Erro ao obter a lista de moedas dos países.")                    
                    completion(nil)
                    
                    return
                }
                      
                if let safeHttpResponse = response as? HTTPURLResponse {
                    let statusCode = safeHttpResponse.statusCode
                    
                    if (200...299).contains(statusCode) {
                        if let safeCurrenciesList = try? JSONDecoder().decode(CurrenciesList.self, from: data!) {
                            var tempCurrencyArray: [Currency] = []
                            
                            for currency in safeCurrenciesList.all {
                                tempCurrencyArray.append(Currency(code: currency.key, name: currency.value))
                            }
                            
                            completion(tempCurrencyArray)
                        }
                        
                    } else {
                        print("Status code inesperado: \(response!)")
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchConversionList(completion: @escaping conversionListCompletion) {
        if canCreateAValidURL(from: Constants.BTG_LIVE_ENDPOINT) {
            let safeUrl = URL(string: Constants.BTG_LIVE_ENDPOINT)!
                        
            let task = URLSession.shared.dataTask(with: safeUrl) { data, response, error in
                
                if let _ = error {
                    print("Erro ao obter a lista de conversões de moedas")
                    
                    completion(nil)
                    return
                }
                      
                if let safeHttpResponse = response as? HTTPURLResponse {
                    let statusCode = safeHttpResponse.statusCode
                    
                    if (200...299).contains(statusCode) {
                        if let safeConversionList = try? JSONDecoder()
                            .decode(ConversionQuotes.self, from: data!) {
                            completion(safeConversionList)                            
                        }
                        
                    } else {                        
                        print("Status code inesperado: \(response!)")
                        return
                    }
                }
            }
            task.resume()
        }
    }
}

// Extraído de https://mobikul.com/check-internet-availability-swift/
fileprivate struct InternetTest {
    func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
