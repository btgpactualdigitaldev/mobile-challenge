import XCTest
import Alamofire
import Data
import Infra

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_correct_url_and_method() throws {
        testRequestFor { request in
            let url = makeUrl()
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_get_should_complete_with_error_when_request_completes_with_error() throws {
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_error_on_all_invalid_cases() throws {
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_200() throws {
        expectedResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_204() throws {
        expectedResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectedResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }
    
    func test_get_should_complete_with_error_when_request_completes_with_non_200() throws {
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
        expectedResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectedResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 100), error: nil))
    }
}

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.get(to: url) { _ in exp.fulfill() }
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectedResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.get(to: makeUrl()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
