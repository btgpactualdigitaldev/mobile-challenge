//
//  ServiceLayerTests.swift
//  BTGProcessoTests
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import XCTest
@testable import BTGProcesso


class ServiceLayerTests: XCTestCase {

    func test_networkManager() {
        let manager = NetworkManager()
        let stringURl = "http://apilayer.net/api/live?access_key=dde04e1875ba595553125a47e403d12c"
        let url = URLRequest(url: URL(string: stringURl)!)
        XCTAssertNotNil(url)
        manager.request(with: url) { (result: Result<Quota,Error>)in
            let quotes = try! result.get().quotes
            for (key,value) in quotes {
                print(key)
                print(value)
            }
        }
    }
    
    func test_createAPIResource() {
        let api = APIResource(endpoint: .live, httpMethod: .get, parameters: [:])
        do {
            let request = try api.request()
            XCTAssertNotNil(request)
            debugPrint(request)

        } catch let error {
            debugPrint(error)
        }
    }
    
    func test_parametersQuotaAPI() {
        let manager = QuotaAPI()
        let api = APIResource(endpoint: .live, httpMethod: .get, parameters: [.currencies: "EUR,GBP,CAD,PLN", .source: "USD", .format: "1"])
        manager.request(with: api) { (coins: Quota?) in
            guard let coins = coins else {
                return
            }
            
            for (key,value) in coins.quotes {
                debugPrint(key)
                debugPrint(value)
            }
            
            
        }
    }

}
