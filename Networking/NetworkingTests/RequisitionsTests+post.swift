//
//  RequisitionsTests+post.swift
//  NetworkingTests
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Combine
import Service
@testable import Networking

class RequisitionsTests_post: XCTestCase {
    
    func testSuccessfulPostRequest() {
        let url = URL(string: "https://example.com")!
        let data = "abc".data(using: .utf8)
        let request = URLRequest(url: url)
        let sentResponse = RequestResponse(data: data, status: .ok, request: request)
        Services.default.register(Requester.self) { MockedRequester(mock: .success(sentResponse)) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        _ = requester.post(to: url)
            .sink(receiveCompletion: { _ in }) { receivedResponse in
                XCTAssert(receivedResponse == sentResponse, "The mocked response sent to the request isn't the same as the received.")
                expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testGettingDecodedValueFromPost() {
        
        struct Person: Codable, Hashable {
            let name = "John"
            let age = 22
        }
        let person = Person()
        
        let url = URL(string: "https://example.com")!
        let data = try! JSONEncoder().encode(Person())
        let request = URLRequest(url: url)
        let sentResponse = RequestResponse(data: data, status: .ok, request: request)
        Services.default.register(Requester.self) { MockedRequester(mock: .success(sentResponse)) }
        let requester: Requester = Services.make(for: Requester.self)
        
        let expectation = self.expectation(description: "Wait response")
        let getPublisher: AnyPublisher<RequestDecodedResponse<Person>, RequestError> = requester.post(to: url, decoder: JSONDecoder())
        _ = getPublisher
            .sink(receiveCompletion: { _ in }) { receivedResponse in
                XCTAssert(receivedResponse.data == person, "The mocked response sent to the request isn't the same as the received.")
                expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 0.1)
    }
}
