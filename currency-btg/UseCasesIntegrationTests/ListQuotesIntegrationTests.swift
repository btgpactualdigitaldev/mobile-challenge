import XCTest
import Data
import Infra
import Domain

class ListQuotesIntegrationTests: XCTestCase {

    func test_() throws {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://api.currencylayer.com/live?access_key=84f27abb6cf24ff40e48b6d1c1e09570")!
        let sut = RemoteListQuotes(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        sut.list { result in
            switch result {
            case .failure: XCTFail("Expected success got \(result) instead")
            case .success(let quotes):
                XCTAssertNotNil(quotes)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
