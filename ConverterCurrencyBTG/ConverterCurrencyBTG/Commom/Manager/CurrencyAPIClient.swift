//
//  CurrencyAPIClient.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 11/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class CurrencyAPIClient: Client {
    var dataTask: URLSessionDataTask?
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func dataTask(with route: CurrencyRouter, completionHandler: @escaping (DataResponse) -> Void) {
        let request = try! route.asURLRequest()
        dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            let dataResponse = DataResponse(request: request, response: response, data: data, error: error)
            completionHandler(dataResponse)
        })
        dataTask?.resume()
    }
    
    func cancel() {
        dataTask?.cancel()
    }
}
