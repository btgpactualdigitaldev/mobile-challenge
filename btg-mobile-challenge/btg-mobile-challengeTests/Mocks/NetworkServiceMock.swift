//
//  NetworkServiceMock.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 02/10/20.
// swiftlint:disable all

import Foundation
@testable import btg_mobile_challenge

final class NetworkServiceMock: NetworkService {

    let bundle: Bundle

    var json: URL?

    var shouldFail: Bool = false
    var unexpectedResponseType: Bool = false
    var missinData: Bool = false
    var statusCode: Int = 200


    init(bundle: Bundle) {
        self.bundle = bundle
    }

    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        if shouldFail {
            completionHandler(nil, nil, NetworkServiceError.requestFailed)
            return NetworkServiceDataTaskMock()
        }

        if unexpectedResponseType {
            completionHandler(nil, nil, nil)
            return NetworkServiceDataTaskMock()
        }

        let urlResponse = HTTPURLResponse(url: with.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)

        if statusCode != 200 {
            completionHandler(nil, urlResponse, nil)
            return NetworkServiceDataTaskMock()
        }

        if missinData {
            completionHandler(nil, urlResponse, nil)
            return NetworkServiceDataTaskMock()
        }

        let data = try! Data(contentsOf: json!)

        completionHandler(data, urlResponse, nil)

        return NetworkServiceDataTaskMock()

    }

}
