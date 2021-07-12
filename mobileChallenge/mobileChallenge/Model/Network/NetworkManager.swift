//
//  NetworkManager.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 26/11/20.
//

import Foundation
import UIKit

//MARK: -Protocols
/// Protocol Network Manager Delegate
protocol NetworkManagerDelegate{
    func didGetCurrencyList(_ networkManager: NetworkManager, _ currencyModel: CurrencyModel)
    func didFailWithError(_ error: Error)
    
}

//MARK: -Structs
/// NetworkManager
struct NetworkManager{
    
    /// Variables
    var delegate: NetworkManagerDelegate?
    let liveURL = "http://apilayer.net/api/live?access_key=e5279203b2e72e3884358896d5215149&format=1"
    
    func fetchCurrency(){
        performRequestLive(with: liveURL)
    }

    /// Perform Live Request (Currencies)
    func performRequestLive(with urlString: String){
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2.Create URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let currency = self.parseCurrencyJSON(safeData) {
                        self.delegate?.didGetCurrencyList(self, currency)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
        
    /// Parse Currency Data
    /// - Parameter currencyData: Currency for Decoder
    /// - Returns: Currency
    func parseCurrencyJSON(_ currencyData: Data) -> CurrencyModel? {
        let decode = JSONDecoder()
        
        do {
            let decodedCurrencyData = try decode.decode(CurrencyExchangeData.self, from: currencyData)
            let quotesData = decodedCurrencyData.quotes
            let currencyQuotes = CurrencyModel(quotes: quotesData)
            return currencyQuotes
        } catch  {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
