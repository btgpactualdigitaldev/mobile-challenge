//
//  APITests.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

import XCTest
@testable import Curriencies

struct CurrencyDummy: Decodable {
    let success: Bool
    let source: String
}

final class NetworkSessionMock: NetworkSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    func loadData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, urlResponse, error)
    }
}

final class APITests: XCTestCase {
    lazy var urlValidCurrency = Bundle(for: type(of: self)).url(forResource: "responseMock", withExtension: "json")
    lazy var urlInvalidCurrency = Bundle(for: type(of: self)).url(forResource: "invalidResponseMock", withExtension: "json")
    let networkSession = NetworkSessionMock()
    private lazy var sut = API(networkSession: networkSession)

    func testFetch_WhenUrlIsInvalid_ShouldReturnError() {
        let expectation = XCTestExpectation(description: "Url Error")
        networkSession.error = RepositoryError.urlUnknown

        sut.fetch(endpoint: "") { (result: Result<CurrencyDummy, RepositoryError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, RepositoryError.urlUnknown)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetch_WhenNoDataReturned_ShouldReturnError() {
        let expectation = XCTestExpectation(description: "No Data")

        sut.fetch(endpoint: "https://google.com/") { (result: Result<CurrencyDummy, RepositoryError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, RepositoryError.noData)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetch_WhenDecoderFailed_ShouldReturnError() throws {
        let expectation = XCTestExpectation(description: "Decoder Error")
        networkSession.error = RepositoryError.decoderError
        let url = try XCTUnwrap(urlInvalidCurrency)
        networkSession.data = try Data(contentsOf: url)

        sut.fetch(endpoint: "https://google.com/") { (result: Result<CurrencyDummy, RepositoryError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, RepositoryError.decoderError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetch_WhenSuccess_ShouldReturnValueDecoded() throws {
        let expectation = XCTestExpectation(description: "Success")
        let url = try XCTUnwrap(urlValidCurrency)
        networkSession.data = try Data(contentsOf: url)

        sut.fetch(endpoint: "https://google.com/") { (result: Result<CurrencyDummy, RepositoryError>) in
            switch result {
            case .success(let currencies):
                XCTAssertEqual(currencies.success, true)
                XCTAssertEqual(currencies.source, "USD")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
