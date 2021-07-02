//
//  ServiceMock.swift
//  BTG_Mobile_ChallengeTests
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation
@testable import BTG_Mobile_Challenge


final class ServiceMock: NetworkService {
 
    let bundle: Bundle
    var json: URL?
    
    var shouldFail: Bool = false
    var invalidCodable: Bool = false
    var unexpectedResponseType: Bool = false
    var missinData: Bool = false
    
    var statusCode: Int = 200
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if shouldFail {
            completionHandler(nil, nil, PurposefulError(title: nil, description: "Request to fail"))
            return ServiceMockDataTask()
        }
        
        if unexpectedResponseType {
            completionHandler(nil, nil, nil)
            return ServiceMockDataTask()
        }
        
        let urlResponse = HTTPURLResponse(url: url.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)

        if statusCode != 200 {
            completionHandler(nil, urlResponse, nil)
            return ServiceMockDataTask()
        }
        
        if missinData {
            completionHandler(nil, urlResponse, nil)
            return ServiceMockDataTask()
        }
        
        let data = try! Data(contentsOf: json!)
        completionHandler(data, urlResponse, nil)
        
        return ServiceMockDataTask()
    }
}
