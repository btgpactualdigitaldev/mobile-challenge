//
//  CurrencylayerCore.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift

class CurrencylayerCore{
    //MARK: Global variables
    
    private static let mainUrl = "http://api.currencylayer.com"
    private static let key = "acf414ff2dcc25141f7e5a7fa62b4a3e"
    
//    static public let sharedInstance = CurrencylayerCore()
    
    // MARK: - Generic GET
    
    static func get(_ endpoint: String) -> Observable<[String: Any]> {
        guard let url = URL(string: mainUrl + endpoint) else {
            return Observable.error(NSError(domain: "Invalid URL",
                                            code: 400,
                                            userInfo: nil))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addParameter(key, forKey: "access_key")
        
        let observable: Observable<[String: Any]> = Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let e = error {
                    observer.onError(e)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        if let data = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] ?? [:]
                                observer.onNext(json)
                            } catch let innerError{
                                observer.onError(innerError)
                            }
                        } else {
                            observer.onError(NSError(domain: "Empty response body", code: 404, userInfo: nil))
                        }
                    } else {
                        observer.onError(NSError(domain: String(data: data ?? Data(), encoding: .utf8) ?? "An unexpected error has ocurred",
                                                 code: httpResponse.statusCode,
                                                 userInfo: nil))
                    }
                } else {
                    observer.onError(NSError(domain: "An unexpected error has ocurred",
                                             code: 400,
                                             userInfo: nil))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).observeOn(MainScheduler.instance)
        
        return observable
    }
}

