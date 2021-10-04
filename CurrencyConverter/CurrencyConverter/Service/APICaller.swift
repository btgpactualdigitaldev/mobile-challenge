//
//  APICaller.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants{
        static let APIListURL = "https://btg-mobile-challenge.herokuapp.com/list"
        static let APIQuotationsURL = "https://btg-mobile-challenge.herokuapp.com/live"
    }
    
    enum APIError: Error{
        case failedToGetData
    }
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod, completion: @escaping (URLRequest) -> Void){
        guard let apiURL = url else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        completion(request)
    }
    
    public func getCurrencies(completion: @escaping (Result<Currency, Error>)-> Void){
        createRequest(with: URL(string: Constants.APIListURL), type: .GET){ request in
            let task = URLSession.shared.dataTask(with: request){
                data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(Currency.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getQuotations(completion: @escaping (Result<Quotation, Error>)-> Void){
        createRequest(with: URL(string: Constants.APIQuotationsURL), type: .GET){ request in
            let task = URLSession.shared.dataTask(with: request){
                data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(Quotation.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
