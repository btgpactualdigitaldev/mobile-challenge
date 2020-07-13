//
//  CurrencyManagerMock.swift
//  ConverterCurrencyBTGTests
//
//  Created by Thiago Vaz on 06/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
@testable import ConverterCurrencyBTG


class CurrencyManagerMock: Client {
    
    func dataTask(with route: CurrencyRouter, completionHandler: @escaping (DataResponse) -> Void) {
        let urlrequest =  try! route.asURLRequest()
        var filename = ""
        switch route {
        case .list:
            filename = "list"
        case .live:
            filename = "live"
        }
        let data = Loader.loadFile(with: filename)
        let response = HTTPURLResponse(url: urlrequest.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dataresponse = DataResponse(request: urlrequest, response: response, data: data, error: nil)
        completionHandler(dataresponse)
    }
    
    func cancel() {
        
    }

}
