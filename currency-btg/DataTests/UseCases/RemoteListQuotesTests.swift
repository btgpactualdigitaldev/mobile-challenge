import XCTest
import Domain
import Data

class RemoteListQuotesTests: XCTestCase {
    
    func test_list_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        
        sut.list() { _ in }
        
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_list_should_complete_with_error_if_client_fails() throws {
        let (sut, httpClientSpy) = makeSut()
        
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_list_should_complete_with_error_if_client_complete_with_invalid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }
    
    func test_list_should_not_complete_if_sut_has_been_deallocated() throws {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteListQuotes? = RemoteListQuotes(url: makeUrl(), httpClient: httpClientSpy)
        var result: ListQuotes.Result?
        sut?.list { result = $0 }
        sut = nil
        httpClientSpy.completeWithData(makeInvalidData())
        XCTAssertNil(result)
    }
}

extension RemoteListQuotesTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteListQuotes, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteListQuotes(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteListQuotes, completeWith expectedResult: ListQuotes.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
       
        let exp = expectation(description: "waiting")
        sut.list() { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
