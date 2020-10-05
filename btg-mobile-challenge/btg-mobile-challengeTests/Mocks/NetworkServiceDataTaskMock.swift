//
//  NetworkServiceDataTaskMock.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 02/10/20.
// swiftlint:disable all

import Foundation

final class NetworkServiceDataTaskMock: URLSessionDataTask {
    private let mock: String

    init(mock: String = "") {
        self.mock = mock
    }
    override func resume() {
        return
    }
}
