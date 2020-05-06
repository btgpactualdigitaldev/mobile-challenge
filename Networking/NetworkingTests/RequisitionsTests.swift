//
//  RequisitionsTests.swift
//  NetworkingTests
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Combine
import Service
@testable import Networking

class RequisitionsTests: XCTestCase {

    func testSuccessfulResponseEqualToSent() {
        let url = URL(string: "https://example.com")!
        let data = "abc".data(using: .utf8)
        let request = URLRequest(url: url)
        let sentResponse = RequestResponse(data: data, status: .ok, request: request)
        Services.default.register(Requester.self) { MockedRequester(mock: .success(sentResponse)) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        _ = requester.request(at: url, method: .get, headers: [:], queryParameters: [:], body: nil)
            .sink(receiveCompletion: { _ in }) { receivedResponse in
                XCTAssert(receivedResponse == sentResponse, "The mocked response sent to the request isn't the same as the received.")
                expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testFailedResponseEqualToSent() {
        Services.default.register(Requester.self) { MockedRequester(mock: .failure(.notHTTPURLResponse)) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        _ = requester.request(at: URL(string: "https://example.com")!, method: .get, headers: [:], queryParameters: [:], body: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssert(error == RequestError.notHTTPURLResponse, "The mocked sent error isn't the same as the received.")
                    expectation.fulfill()
                default: break
                }
            }) { _ in }
        
        self.wait(for: [expectation], timeout: 0.1)
    }

}
